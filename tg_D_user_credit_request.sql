-- funcion del trigger de eliminar en la tabla cw.user_credit_request
CREATE OR REPLACE FUNCTION audit.f_tg_D_user_credit_request() RETURNS TRIGGER AS $tg_D_user_credit_request$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.user_credit_request
    (
			id,
			user_id_old,
			bank_id_old,
			requested_amount_old,
			monthly_payment_old,
			request_date_old,
			ingreso_declarado_old,
			plazo_solicitado_old,
			reason_old,
			approved_old,
			folio_old,
			mensualidad_final_old,
			plazo_final_old,
			linea_aprobada_final_old,
			tasa_final_old,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			OLD.id,
			OLD.user_id,
			OLD.bank_id,
			OLD.requested_amount,
			OLD.monthly_payment,
			OLD.request_date,
			OLD.ingreso_declarado,
			OLD.plazo_solicitado,
			OLD.reason,
			OLD.approved,
			OLD.folio,
			OLD.mensualidad_final,
			OLD.plazo_final,
			OLD.linea_aprobada_final,
			OLD.tasa_final,
			user_name,
			'DELETE',
			now()
		);
      RETURN NULL;
  END;

$tg_D_user_credit_request$ LANGUAGE 'plpgsql';

-- trigger para eliminar user_credit_request
CREATE TRIGGER tg_D_user_credit_request AFTER DELETE
ON cw.user_credit_request FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_D_user_credit_request();
