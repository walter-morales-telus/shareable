/*Set Active Slimline Camera*/
update nc_params
set list_value_id = 7021759771013444981 /* Active */
where attr_id = 7021759771013444983 /* Status */
and object_id in (
    9151670283613311260 /* Doorbell Camera - Slimline TELUS Easy Pay B2C */,
    9150454993513203662 /* Doorbell Camera - Slimline Purchase */,
    9151963809313418384 /* Doorbell Camera - Slimline */
);

update nc_params
set list_value_id = 7021759771013444982 /* Historic */
where attr_id = 7021759771013444983 /* Status */
and object_id in
(
    9166745162238078126 /* Wedge Mount Kit for ADC-VDB750 */,
    9166665873774682985 /* Slimline Backplate Adapter for ADC-VDB750 */,
    9166659877040411404 /* Digital Circuit Adapter for ADC-VDB750 */,
    9166658021274411398 /* Doorbell Camera ADC-VDB750 Purchase */,
    9166778781572421584 /* Doorbell Camera ADC-VDB750 */,
    9166745837234612699 /* Doorbell Camera ADC-VDB750 Easy Pay */,
    9166650556772199042 /* Doorbell Camera ADC-VDB750 */,
    9166789229588112970 /* Doorbell Camera ADC-VDB750 */,
    9166952936812542758 /* Doorbell Camera - ADC-VDB750 */,
    9166891116406421890 /* Doorbell Camera ADC-VDB750 */,
    9166953509121542759 /* Doorbell Camera ADC-VDB750 */
);




