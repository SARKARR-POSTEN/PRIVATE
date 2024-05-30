DECLARE
  lv_procedure_name VARCHAR2(200) := 'refresh_main';
  lv_error_msg      VARCHAR2(2000);
  lv_stage          VARCHAR2(200);
  l_party_id        NUMBER;
  e_error           EXCEPTION;
  lv_duns_number    VARCHAR2(200);
  x_cre_ret         NUMBER;
  X_CRE_MSG         VARCHAR2(2000);
  V_ORG_NAME        VARCHAR2(30);
  T_ORG_NO          VARCHAR2(200);
  CURSOR CUR_ORG_NUMBER
  IS
    SELECT JGZZ_FISCAL_CODE,
      DUNS_NUMBER,
      COUNTRY,
      ATTRIBUTE17
    FROM HZ_PARTIES
    WHERE 1 = 1
      --AND Attribute7 = 'Y'
    AND STATUS = 'A'
    AND PARTY_ID IN (select p.party_id from xxcu_refresh_se_280524_ms p where 1=1);
BEGIN
  DBMS_OUTPUT.PUT_LINE('Process Start Date'|| Sysdate);
  fnd_global.APPS_INITIALIZE(user_id=>1191, RESP_ID=>51241, resp_appl_id=>879);
  FOR REC_ORG_NUMBER IN CUR_ORG_NUMBER
  LOOP
    V_ORG_NAME:=REC_ORG_NUMBER.JGZZ_FISCAL_CODE;
    -- LV_STAGE := 'In parameters p_org_no:'||REC_ORG_NUMBER.JGZZ_FISCAL_CODE||' p_duns_number:'||REC_ORG_NUMBER.DUNS_NUMBER||' p_country:'||REC_ORG_NUMBER.COUNTRY||' p_source:'||'AD_HOC';
    -- DBMS_OUTPUT.PUT_LINE('Record processing '|| LV_STAGE);
    BEGIN
      SELECT party_id
      INTO l_party_id
      FROM HZ_PARTIES hp
      WHERE jgzz_fiscal_code = REC_ORG_NUMBER.JGZZ_FISCAL_CODE
      AND ATTRIBUTE17        = REC_ORG_NUMBER.ATTRIBUTE17
      AND status             ='A'
      AND created_by_module IN
        (SELECT lookup_code
        FROM FND_LOOKUP_VALUES
        WHERE lookup_type='XXCU_BIS_REF_CREATE_MOD_LKP'
        AND enabled_flag ='Y'
        )
      AND NOT EXISTS
        (SELECT 1 FROM ap_suppliers apsup WHERE apsup.party_id = hp.party_id
        )
      AND NOT EXISTS
        (SELECT 1
        FROM HZ_CODE_ASSIGNMENTS
        WHERE OWNER_TABLE_NAME='HZ_PARTIES'
        AND class_code       IN ('BANK', 'CLEARINGHOUSE','BANK_BRANCH')
        AND class_category   IN ( 'BANK_INSTITUTION_TYPE','BANK_BRANCH_TYPE')
        AND owner_table_id    = hp.PARTY_ID
        )
      AND NOT EXISTS
        (SELECT 1
        FROM HZ_parties
        WHERE PARTY_TYPE='ORGANIZATION'
        AND (created_by_module LIKE 'FUN_AGIS'
        OR created_by_module LIKE 'XLE_CREATE_LE')
        AND party_id=hp.PARTY_ID
        );
      ------Condition addition end for 8373
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      LV_STAGE := 'Party does not exists in the system '||REC_ORG_NUMBER.JGZZ_FISCAL_CODE;
      DBMS_OUTPUT.PUT_LINE('ERROR:'|| LV_STAGE);
    WHEN OTHERS THEN
      LV_STAGE := 'Error while checking party '||REC_ORG_NUMBER.JGZZ_FISCAL_CODE||SQLERRM;
      DBMS_OUTPUT.PUT_LINE('ERROR:'|| LV_STAGE);
    END;
    BEGIN
      INSERT
      INTO XXCU.XXCU_credit_refresh_tbl
        (
          Orgno,
          Country,
          Duns_number,
          source,
          Party_id,
          search_status,
          upd_status,
          refresh_status,
          creation_date
        )
        VALUES
        (
          REC_ORG_NUMBER.JGZZ_FISCAL_CODE,
          REC_ORG_NUMBER.ATTRIBUTE17,
          REC_ORG_NUMBER.DUNS_NUMBER,
          'AD_HOC',
          l_party_id,
          'NEW',
          'NEW',
          'NEW',
          sysdate
        );
    EXCEPTION
    WHEN OTHERS THEN
      LV_STAGE := 'Error while fetching party id '||REC_ORG_NUMBER.JGZZ_FISCAL_CODE||SQLERRM;
      DBMS_OUTPUT.PUT_LINE('ERROR:'|| LV_STAGE);
      UPDATE XXCU_TEST_ORG_NUMBER
      SET CREATION_DATE = SYSDATE,
        STATUS          = 'ERROR',
        ERROR_MESSAGE   =SUBSTR(LV_STAGE, 0,250)
      WHERE ORG_NUMBER  = REC_ORG_NUMBER.JGZZ_FISCAL_CODE;
    END;
    BEGIN
      UPDATE XXCU_TEST_ORG_NUMBER
      SET STATUS       = 'PROCESSED',
        CREATION_DATE  = SYSDATE
      WHERE ORG_NUMBER = REC_ORG_NUMBER.JGZZ_FISCAL_CODE;
      COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
      LV_STAGE := 'Error while pdating custom table '||REC_ORG_NUMBER.JGZZ_FISCAL_CODE||SQLERRM;
      DBMS_OUTPUT.PUT_LINE('ERROR:'|| LV_STAGE);
    END;
  END LOOP;
  XXCU_CREDIT_REFRESH_PKG.CUSTOMER_REFRESH(X_CRE_MSG,X_CRE_RET,NULL);
  DBMS_OUTPUT.PUT_LINE('Process End Date'|| Sysdate);
EXCEPTION
WHEN OTHERS THEN
  LV_STAGE := 'Error while pdating out block '||V_ORG_NAME||SQLERRM;
  UPDATE XXCU_TEST_ORG_NUMBER
  SET CREATION_DATE = SYSDATE,
    STATUS          = 'ERROR',
    ERROR_MESSAGE   =SUBSTR(LV_STAGE, 0,250)
  WHERE ORG_NUMBER  = V_ORG_NAME;
  COMMIT;
END;
/