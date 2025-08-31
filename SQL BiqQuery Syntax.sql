CREATE TABLE `kimia_farma.analysis_table` AS
WITH final_transaction_laba AS (
    SELECT *,
        CASE
            WHEN price <= 50000 THEN 0.10
            WHEN price > 50000 AND price <= 100000 THEN 0.15
            WHEN price > 100000 AND price <= 300000 THEN 0.20
            WHEN price > 300000 AND price <= 500000 THEN 0.25
            WHEN price > 500000 THEN 0.30
        END AS persentase_gross_laba,
        price - (price * discount_percentage) AS nett_sales
    FROM `kimia_farma.final_transaction`
)

SELECT
    ft.transaction_id,
    ft.date,
    ft.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    ft.customer_name,
    ft.product_id,
    p.product_name,
    p.price AS actual_price,
    ft.discount_percentage,
    ft.persentase_gross_laba,
    ft.nett_sales,
    ft.nett_sales * ft.persentase_gross_laba AS nett_profit,
    ft.rating AS rating_transaksi
FROM final_transaction_laba AS ft
JOIN `kimia_farma.kantor_cabang` AS kc
    ON ft.branch_id = kc.branch_id
JOIN `kimia_farma.product` AS p
    ON ft.product_id = p.product_id;
