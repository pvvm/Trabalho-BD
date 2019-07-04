CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `view_medias_anuais` AS
    SELECT 
        TRUNCATE(AVG(`temperatura`.`temp_Min`),
            1) AS `Temp. mínima`,
        TRUNCATE(AVG(`temperatura`.`temp_Med`),
            1) AS `Temp. média`,
        TRUNCATE(AVG(`temperatura`.`temp_Max`),
            1) AS `Temp. máxima`,
        TRUNCATE(AVG(`umidade`.`umi_Min`), 1) AS `Umidade mínima`,
        TRUNCATE(AVG(`umidade`.`umi_Med`), 1) AS `Umidade média`,
        TRUNCATE(AVG(`umidade`.`umi_Max`), 1) AS `Umidade máxima`,
        TRUNCATE(AVG(`pressao_atm`.`patm_Med`),
            1) AS `Press. atm.`,
        TRUNCATE(AVG(`precipitacao`.`precipit_Med`),
            1) AS `Precipitação`,
        TRUNCATE(AVG(`insolacao`.`ins_med`), 1) AS `Insolação atmosf.`,
        TRUNCATE(AVG(`evaporacao`.`evap_med`),
            1) AS `Evaporação`,
        TRUNCATE(AVG(`nebulosidade`.`ceu_encoberto`),
            1) AS `Índice de nebulosidade`,
        TRUNCATE(AVG(`ventos`.`vel_Med`), 1) AS `Intens. eólica`
    FROM
        (((((((`temperatura`
        JOIN `umidade`)
        JOIN `pressao_atm`)
        JOIN `insolacao`)
        JOIN `precipitacao`)
        JOIN `evaporacao`)
        JOIN `nebulosidade`)
        JOIN `ventos`)