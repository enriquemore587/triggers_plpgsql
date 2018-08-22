-- funcion del trigger de UPDATE user_credit_request
CREATE OR REPLACE FUNCTION audit.f_tg_U_user_credit_request() RETURNS TRIGGER AS $tg_U_user_credit_request$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.user_credit_request
    (
			id,
			user_id_new,
			bank_id_new,
			requested_amount_new,
			monthly_payment_new,
			request_date_new,
			ingreso_declarado_new,
			plazo_solicitado_new,
			reason_new,
			approved_new,
			folio_new,
			mensualidad_final_new,
			plazo_final_new,
			linea_aprobada_final_new,
			tasa_final_new,
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
			NEW.id,
			NEW.user_id,
			NEW.bank_id,
			NEW.requested_amount,
			NEW.monthly_payment,
			NEW.request_date,
			NEW.ingreso_declarado,
			NEW.plazo_solicitado,
			NEW.reason,
			NEW.approved,
			NEW.folio,
			NEW.mensualidad_final,
			NEW.plazo_final,
			NEW.linea_aprobada_final,
			NEW.tasa_final,
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
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$tg_U_user_credit_request$ LANGUAGE 'plpgsql';

-- trigger para UPDATE user_credit_request
CREATE TRIGGER tg_U_user_credit_request AFTER UPDATE
ON cw.user_credit_request FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_user_credit_request();