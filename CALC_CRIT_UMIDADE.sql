CREATE DEFINER=`root`@`localhost` PROCEDURE `calc_crit_umidade`(OUT umi_normal INT, OUT umi_atencao INT, OUT umi_alerta INT, OUT umi_emergencia INT)
BEGIN
	SELECT COUNT(umi_Min)
		FROM umidade
        WHERE umi_Min > 30
        INTO umi_normal;
        
	SELECT COUNT(umi_Min)
		FROM umidade
        WHERE umi_Min <= 30 AND umi_Min > 20
        INTO umi_atencao;
        
	SELECT COUNT(umi_Min)
		FROM umidade
        WHERE umi_Min <= 20 AND umi_Min >= 12
        INTO umi_alerta;
        
	SELECT COUNT(umi_Min)
		FROM umidade
		WHERE umi_Min < 12
        INTO umi_emergencia;
END