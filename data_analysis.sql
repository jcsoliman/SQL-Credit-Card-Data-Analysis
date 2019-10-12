--How can you isolate (or group) the transactions of each cardholder?

SELECT card_holder.id AS "Cardholder ID",
		card_holder.name as "Cardholder Name",
		credit_card.card as "Credit Card Number",
		transactions.id as "Transaction ID",
		transactions.date as "Transaction Date",
		transactions.amount as "Transaction Amount",
		transactions.id_merchant as "Merchant ID",
		merchant.name as "Merchant Name",
		merchant_category.name as "Merchant Category"
FROM card_holder LEFT JOIN credit_card ON card_holder.id = credit_card.cardholder_id
LEFT JOIN transactions ON credit_card.card = transactions.card
LEFT JOIN merchant ON transactions.id_merchant = merchant.id
LEFT JOIN merchant_category on merchant.id_merchant_category = merchant_category.id;
-- GROUP BY card_holder.id

--Consider the time period 7:00 a.m. to 9:00 a.m.
--What are the top 100 highest transactions during this time period?

SELECT card_holder.id AS "Cardholder ID",
		card_holder.name as "Cardholder Name",
		credit_card.card as "Credit Card Number",
		transactions.id as "Transaction ID",
		transactions.date as "Transaction Date",
		transactions.amount as "Transaction Amount",
		transactions.id_merchant as "Merchant ID",
		merchant.name as "Merchant Name",
		merchant_category.name as "Merchant Category"
FROM card_holder LEFT JOIN credit_card ON card_holder.id = credit_card.cardholder_id
LEFT JOIN transactions ON credit_card.card = transactions.card
LEFT JOIN merchant ON transactions.id_merchant = merchant.id
LEFT JOIN merchant_category on merchant.id_merchant_category = merchant_category.id
WHERE EXTRACT(HOUR FROM date)>= 7 AND EXTRACT(HOUR FROM date)<9
ORDER BY transactions.amount DESC LIMIT 100;

--Do you see any fraudulent or anomalous transactions?
--Yes

--If you answered yes to the previous question,
--explain why you think there might be fraudulent transactions during this time frame.
--It is odd to see big transactions at a bar or a pub in the morning.
--Between 7:00am and 9:00am:
--Transaction IDs 3163, 2451, 2840, and 208 amount to spending at a bar/pub of more than 700 each.
--It's also interesting to see big spend in a restaurant between those hours, although that could be explained by a big group
--Transactions 1442 and 968 amount to more than 1000 each.
--Similar observation could be said for Transaction 1620, spending of 1009 at a coffee shop.
--It's worth noting that these transactions were made by 5 people.

--Some fraudsters hack a credit card by making several small payments (generally less than $2.00),
--which are typically ignored by cardholders. Count the transactions that are less than $2.00 per cardholder.

SELECT card_holder.id AS "Cardholder ID",
		card_holder.name as "Cardholder Name",
		COUNT(transactions.id) as "Number of Transactions"
FROM card_holder LEFT JOIN credit_card ON card_holder.id = credit_card.cardholder_id
LEFT JOIN transactions ON credit_card.card = transactions.card
WHERE transactions.amount < 2
GROUP BY card_holder.id, card_holder.name
ORDER BY "Number of Transactions" DESC;

--Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.
--Interesting observation, but not enough evidence to suggest hacking, on Megan Price, Peter McKay,
--Stephanie Dalton, Brandon Pineda each with more than 20 number of transactions less than 2.00

--What are the top 5 merchants prone to being hacked using small transactions?

SELECT merchant.id as "Merchant ID",
		merchant.name as "Merchant Name",
		COUNT(transactions.id) as "Number of Transactions"
FROM merchant LEFT JOIN transactions ON merchant.id = transactions.id_merchant
WHERE transactions.amount < 2
GROUP BY merchant.id, merchant.name
ORDER BY "Number of Transactions" DESC LIMIT 5;

--Wood-Ramirez, Hood-Phillips, Baker Inc, Clark and Sons, Greene-Wood

Once you have a query that can be reused, create a view for each of the previous queries.