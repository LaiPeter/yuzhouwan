DROP TABLE IF EXISTS `ab_user` ;
CREATE TABLE IF NOT EXISTS `ab_user` (

	id INTEGER NOT NULL, 
	first_name VARCHAR(64) NOT NULL, 
	last_name VARCHAR(64) NOT NULL, 
	username VARCHAR(64) NOT NULL, 
	password VARCHAR(256), 
	active BOOLEAN, 
	email VARCHAR(64) NOT NULL, 
	last_login DATETIME, 
	login_count INTEGER, 
	fail_login_count INTEGER, 
	created_on DATETIME, 
	changed_on DATETIME, 
	created_by_fk INTEGER, 
	changed_by_fk INTEGER, 
	PRIMARY KEY (id), 
	UNIQUE (username), 
	CHECK (active IN (0, 1)), 
	UNIQUE (email), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `ab_view_menu` ;
CREATE TABLE IF NOT EXISTS `ab_view_menu` (

	id INTEGER NOT NULL, 
	name VARCHAR(100) NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (name)
);
DROP TABLE IF EXISTS `ab_role` ;
CREATE TABLE IF NOT EXISTS `ab_role` (

	id INTEGER NOT NULL, 
	name VARCHAR(64) NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (name)
);
DROP TABLE IF EXISTS `ab_permission` ;
CREATE TABLE IF NOT EXISTS `ab_permission` (

	id INTEGER NOT NULL, 
	name VARCHAR(100) NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (name)
);
DROP TABLE IF EXISTS `ab_register_user` ;
CREATE TABLE IF NOT EXISTS `ab_register_user` (

	id INTEGER NOT NULL, 
	first_name VARCHAR(64) NOT NULL, 
	last_name VARCHAR(64) NOT NULL, 
	username VARCHAR(64) NOT NULL, 
	password VARCHAR(256), 
	email VARCHAR(64) NOT NULL, 
	registration_date DATETIME, 
	registration_hash VARCHAR(256), 
	PRIMARY KEY (id), 
	UNIQUE (username)
);
DROP TABLE IF EXISTS `ab_user_role` ;
CREATE TABLE IF NOT EXISTS `ab_user_role` (

	id INTEGER NOT NULL, 
	user_id INTEGER, 
	role_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(user_id) REFERENCES ab_user (id), 
	FOREIGN KEY(role_id) REFERENCES ab_role (id)
);
DROP TABLE IF EXISTS `ab_permission_view` ;
CREATE TABLE IF NOT EXISTS `ab_permission_view` (

	id INTEGER NOT NULL, 
	permission_id INTEGER, 
	view_menu_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(permission_id) REFERENCES ab_permission (id), 
	FOREIGN KEY(view_menu_id) REFERENCES ab_view_menu (id)
);
DROP TABLE IF EXISTS `ab_permission_view_role` ;
CREATE TABLE IF NOT EXISTS `ab_permission_view_role` (

	id INTEGER NOT NULL, 
	permission_view_id INTEGER, 
	role_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(permission_view_id) REFERENCES ab_permission_view (id), 
	FOREIGN KEY(role_id) REFERENCES ab_role (id)
);
DROP TABLE IF EXISTS `alembic_version` ;
CREATE TABLE IF NOT EXISTS `alembic_version` (

	version_num VARCHAR(32) NOT NULL
);
DROP TABLE IF EXISTS `dashboards` ;
CREATE TABLE IF NOT EXISTS `dashboards` (

	created_on DATETIME NOT NULL, 
	changed_on DATETIME NOT NULL, 
	id INTEGER NOT NULL, 
	dashboard_title VARCHAR(500), 
	position_json TEXT, 
	created_by_fk INTEGER, 
	changed_by_fk INTEGER, css TEXT, description TEXT, slug VARCHAR(255), json_metadata TEXT, 
	PRIMARY KEY (id), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `dbs` ;
CREATE TABLE IF NOT EXISTS `dbs` (

	created_on DATETIME NOT NULL, 
	changed_on DATETIME NOT NULL, 
	id INTEGER NOT NULL, 
	database_name VARCHAR(250), 
	sqlalchemy_uri VARCHAR(1024), 
	created_by_fk INTEGER, 
	changed_by_fk INTEGER, password BLOB, cache_timeout INTEGER, extra TEXT, select_as_create_table_as BOOLEAN, allow_ctas BOOLEAN, expose_in_sqllab BOOLEAN, force_ctas_schema VARCHAR(250), allow_run_async BOOLEAN, allow_run_sync BOOLEAN, allow_dml BOOLEAN, perm VARCHAR(1000), 
	PRIMARY KEY (id), 
	UNIQUE (database_name), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `metrics` ;
CREATE TABLE IF NOT EXISTS `metrics` (

	id INTEGER NOT NULL, 
	metric_name VARCHAR(512), 
	verbose_name VARCHAR(1024), 
	metric_type VARCHAR(32), 
	datasource_name VARCHAR(255), 
	json TEXT, 
	description TEXT, changed_by_fk INTEGER, changed_on DATETIME, created_by_fk INTEGER, created_on DATETIME, is_restricted BOOLEAN, d3format VARCHAR(128), 
	PRIMARY KEY (id), 
	FOREIGN KEY(datasource_name) REFERENCES datasources (datasource_name), 
	FOREIGN KEY(datasource_name) REFERENCES datasources (datasource_name)
);
DROP TABLE IF EXISTS `slices` ;
CREATE TABLE IF NOT EXISTS `slices` (

	created_on DATETIME NOT NULL, 
	changed_on DATETIME NOT NULL, 
	id INTEGER NOT NULL, 
	slice_name VARCHAR(250), 
	druid_datasource_id INTEGER, 
	table_id INTEGER, 
	datasource_type VARCHAR(200), 
	datasource_name VARCHAR(2000), 
	viz_type VARCHAR(250), 
	params TEXT, 
	created_by_fk INTEGER, 
	changed_by_fk INTEGER, description TEXT, cache_timeout INTEGER, perm VARCHAR(2000), datasource_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(druid_datasource_id) REFERENCES datasources (id), 
	FOREIGN KEY(table_id) REFERENCES tables (id), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `sql_metrics` ;
CREATE TABLE IF NOT EXISTS `sql_metrics` (

	created_on DATETIME NOT NULL, 
	changed_on DATETIME NOT NULL, 
	id INTEGER NOT NULL, 
	metric_name VARCHAR(512), 
	verbose_name VARCHAR(1024), 
	metric_type VARCHAR(32), 
	table_id INTEGER, 
	expression TEXT, 
	description TEXT, 
	created_by_fk INTEGER, 
	changed_by_fk INTEGER, is_restricted BOOLEAN, d3format VARCHAR(128), 
	PRIMARY KEY (id), 
	FOREIGN KEY(table_id) REFERENCES tables (id), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `dashboard_slices` ;
CREATE TABLE IF NOT EXISTS `dashboard_slices` (

	id INTEGER NOT NULL, 
	dashboard_id INTEGER, 
	slice_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(dashboard_id) REFERENCES dashboards (id), 
	FOREIGN KEY(slice_id) REFERENCES slices (id)
);
DROP TABLE IF EXISTS `logs` ;
CREATE TABLE IF NOT EXISTS `logs` (

	id INTEGER NOT NULL, 
	action VARCHAR(512), 
	user_id INTEGER, 
	json TEXT, 
	dttm DATETIME, dashboard_id INTEGER, slice_id INTEGER, dt DATE, 
	PRIMARY KEY (id), 
	FOREIGN KEY(user_id) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `url` ;
CREATE TABLE IF NOT EXISTS `url` (

	created_on DATETIME NOT NULL, 
	changed_on DATETIME NOT NULL, 
	id INTEGER NOT NULL, 
	url TEXT, 
	created_by_fk INTEGER, 
	changed_by_fk INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `css_templates` ;
CREATE TABLE IF NOT EXISTS `css_templates` (

	created_on DATETIME NOT NULL, 
	changed_on DATETIME NOT NULL, 
	id INTEGER NOT NULL, 
	template_name VARCHAR(250), 
	css TEXT, 
	changed_by_fk INTEGER, 
	created_by_fk INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `favstar` ;
CREATE TABLE IF NOT EXISTS `favstar` (

	id INTEGER NOT NULL, 
	user_id INTEGER, 
	class_name VARCHAR(50), 
	obj_id INTEGER, 
	dttm DATETIME, 
	PRIMARY KEY (id), 
	FOREIGN KEY(user_id) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `dashboard_user` ;
CREATE TABLE IF NOT EXISTS `dashboard_user` (

	id INTEGER NOT NULL, 
	user_id INTEGER, 
	dashboard_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(dashboard_id) REFERENCES dashboards (id), 
	FOREIGN KEY(user_id) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `slice_user` ;
CREATE TABLE IF NOT EXISTS `slice_user` (

	id INTEGER NOT NULL, 
	user_id INTEGER, 
	slice_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(slice_id) REFERENCES slices (id), 
	FOREIGN KEY(user_id) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `clusters` ;
CREATE TABLE IF NOT EXISTS `clusters` (

	created_on DATETIME NOT NULL, 
	changed_on DATETIME NOT NULL, 
	id INTEGER NOT NULL, 
	cluster_name VARCHAR(250), 
	coordinator_host VARCHAR(255), 
	coordinator_port INTEGER, 
	coordinator_endpoint VARCHAR(255), 
	broker_host VARCHAR(255), 
	broker_port INTEGER, 
	broker_endpoint VARCHAR(255), 
	metadata_last_refreshed DATETIME, 
	created_by_fk INTEGER, 
	changed_by_fk INTEGER, cache_timeout INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id), 
	UNIQUE (cluster_name), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `columns` ;
CREATE TABLE IF NOT EXISTS `columns` (

	created_on DATETIME NOT NULL, 
	changed_on DATETIME NOT NULL, 
	id INTEGER NOT NULL, 
	datasource_name VARCHAR(255), 
	column_name VARCHAR(255), 
	is_active BOOLEAN, 
	type VARCHAR(32), 
	groupby BOOLEAN, 
	count_distinct BOOLEAN, 
	sum BOOLEAN, 
	max BOOLEAN, 
	min BOOLEAN, 
	filterable BOOLEAN, 
	description TEXT, 
	created_by_fk INTEGER, 
	changed_by_fk INTEGER, avg BOOLEAN, dimension_spec_json TEXT, 
	PRIMARY KEY (id), 
	CHECK (is_active IN (0, 1)), 
	CHECK (groupby IN (0, 1)), 
	CHECK (count_distinct IN (0, 1)), 
	CHECK (sum IN (0, 1)), 
	CHECK (max IN (0, 1)), 
	CHECK (min IN (0, 1)), 
	CHECK (filterable IN (0, 1)), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `datasources` ;
CREATE TABLE IF NOT EXISTS `datasources` (

	created_on DATETIME NOT NULL, 
	changed_on DATETIME NOT NULL, 
	id INTEGER NOT NULL, 
	datasource_name VARCHAR(255), 
	is_featured BOOLEAN, 
	is_hidden BOOLEAN, 
	description TEXT, 
	default_endpoint TEXT, 
	user_id INTEGER, 
	cluster_name VARCHAR(250), 
	created_by_fk INTEGER, 
	changed_by_fk INTEGER, 
	"offset" INTEGER, 
	cache_timeout INTEGER, perm VARCHAR(1000), 
	PRIMARY KEY (id), 
	CHECK (is_featured IN (0, 1)), 
	CHECK (is_hidden IN (0, 1)), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(cluster_name) REFERENCES clusters (cluster_name), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(user_id) REFERENCES ab_user (id), 
	UNIQUE (datasource_name)
);
DROP TABLE IF EXISTS `table_columns` ;
CREATE TABLE IF NOT EXISTS `table_columns` (

	created_on DATETIME NOT NULL, 
	changed_on DATETIME NOT NULL, 
	id INTEGER NOT NULL, 
	table_id INTEGER, 
	column_name VARCHAR(255), 
	is_dttm BOOLEAN, 
	is_active BOOLEAN, 
	type VARCHAR(32), 
	groupby BOOLEAN, 
	count_distinct BOOLEAN, 
	sum BOOLEAN, 
	max BOOLEAN, 
	min BOOLEAN, 
	filterable BOOLEAN, 
	description TEXT, 
	created_by_fk INTEGER, 
	changed_by_fk INTEGER, 
	expression TEXT, 
	verbose_name VARCHAR(1024), python_date_format VARCHAR(255), database_expression VARCHAR(255), avg BOOLEAN, 
	PRIMARY KEY (id), 
	CHECK (is_dttm IN (0, 1)), 
	CHECK (is_active IN (0, 1)), 
	CHECK (groupby IN (0, 1)), 
	CHECK (count_distinct IN (0, 1)), 
	CHECK (sum IN (0, 1)), 
	CHECK (max IN (0, 1)), 
	CHECK (min IN (0, 1)), 
	CHECK (filterable IN (0, 1)), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(table_id) REFERENCES tables (id)
);
DROP TABLE IF EXISTS `tables` ;
CREATE TABLE IF NOT EXISTS `tables` (

	created_on DATETIME NOT NULL, 
	changed_on DATETIME NOT NULL, 
	id INTEGER NOT NULL, 
	table_name VARCHAR(250), 
	main_dttm_col VARCHAR(250), 
	default_endpoint TEXT, 
	database_id INTEGER NOT NULL, 
	created_by_fk INTEGER, 
	changed_by_fk INTEGER, 
	"offset" INTEGER, 
	description TEXT, 
	is_featured BOOLEAN, 
	user_id INTEGER, 
	cache_timeout INTEGER, 
	schema VARCHAR(255), sql TEXT, params TEXT, perm VARCHAR(1000), 
	PRIMARY KEY (id), 
	CHECK (is_featured IN (0, 1)), 
	CONSTRAINT user_id FOREIGN KEY(user_id) REFERENCES ab_user (id), 
	UNIQUE (table_name), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(database_id) REFERENCES dbs (id), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `access_request` ;
CREATE TABLE IF NOT EXISTS `access_request` (

	created_on DATETIME, 
	changed_on DATETIME, 
	id INTEGER NOT NULL, 
	datasource_type VARCHAR(200), 
	datasource_id INTEGER, 
	changed_by_fk INTEGER, 
	created_by_fk INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(changed_by_fk) REFERENCES ab_user (id), 
	FOREIGN KEY(created_by_fk) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `query` ;
CREATE TABLE IF NOT EXISTS `query` (

	id INTEGER NOT NULL, 
	client_id VARCHAR(11) NOT NULL, 
	database_id INTEGER NOT NULL, 
	tmp_table_name VARCHAR(256), 
	tab_name VARCHAR(256), 
	sql_editor_id VARCHAR(256), 
	user_id INTEGER, 
	status VARCHAR(16), 
	schema VARCHAR(256), 
	sql TEXT, 
	select_sql TEXT, 
	executed_sql TEXT, 
	"limit" INTEGER, 
	limit_used BOOLEAN, 
	select_as_cta BOOLEAN, 
	select_as_cta_used BOOLEAN, 
	progress INTEGER, 
	rows INTEGER, 
	error_message TEXT, 
	start_time NUMERIC(20, 6), 
	changed_on DATETIME, 
	end_time NUMERIC(20, 6), results_key VARCHAR(64), 
	PRIMARY KEY (id), 
	CHECK (limit_used IN (0, 1)), 
	CHECK (select_as_cta IN (0, 1)), 
	CHECK (select_as_cta_used IN (0, 1)), 
	CONSTRAINT client_id UNIQUE (client_id), 
	FOREIGN KEY(database_id) REFERENCES dbs (id), 
	FOREIGN KEY(user_id) REFERENCES ab_user (id)
);
DROP TABLE IF EXISTS `energy_usage` ;
CREATE TABLE IF NOT EXISTS `energy_usage` (

	source VARCHAR(255), 
	target VARCHAR(255), 
	value FLOAT
);
DROP TABLE IF EXISTS `wb_health_population` ;
CREATE TABLE IF NOT EXISTS `wb_health_population` (

	"NY_GNP_PCAP_CD" FLOAT, 
	"SE_ADT_1524_LT_FM_ZS" FLOAT, 
	"SE_ADT_1524_LT_MA_ZS" FLOAT, 
	"SE_ADT_1524_LT_ZS" FLOAT, 
	"SE_ADT_LITR_FE_ZS" FLOAT, 
	"SE_ADT_LITR_MA_ZS" FLOAT, 
	"SE_ADT_LITR_ZS" FLOAT, 
	"SE_ENR_ORPH" FLOAT, 
	"SE_PRM_CMPT_FE_ZS" FLOAT, 
	"SE_PRM_CMPT_MA_ZS" FLOAT, 
	"SE_PRM_CMPT_ZS" FLOAT, 
	"SE_PRM_ENRR" FLOAT, 
	"SE_PRM_ENRR_FE" FLOAT, 
	"SE_PRM_ENRR_MA" FLOAT, 
	"SE_PRM_NENR" FLOAT, 
	"SE_PRM_NENR_FE" FLOAT, 
	"SE_PRM_NENR_MA" FLOAT, 
	"SE_SEC_ENRR" FLOAT, 
	"SE_SEC_ENRR_FE" FLOAT, 
	"SE_SEC_ENRR_MA" FLOAT, 
	"SE_SEC_NENR" FLOAT, 
	"SE_SEC_NENR_FE" FLOAT, 
	"SE_SEC_NENR_MA" FLOAT, 
	"SE_TER_ENRR" FLOAT, 
	"SE_TER_ENRR_FE" FLOAT, 
	"SE_XPD_TOTL_GD_ZS" FLOAT, 
	"SH_ANM_CHLD_ZS" FLOAT, 
	"SH_ANM_NPRG_ZS" FLOAT, 
	"SH_CON_1524_FE_ZS" FLOAT, 
	"SH_CON_1524_MA_ZS" FLOAT, 
	"SH_CON_AIDS_FE_ZS" FLOAT, 
	"SH_CON_AIDS_MA_ZS" FLOAT, 
	"SH_DTH_COMM_ZS" FLOAT, 
	"SH_DTH_IMRT" FLOAT, 
	"SH_DTH_INJR_ZS" FLOAT, 
	"SH_DTH_MORT" FLOAT, 
	"SH_DTH_NCOM_ZS" FLOAT, 
	"SH_DTH_NMRT" FLOAT, 
	"SH_DYN_AIDS" FLOAT, 
	"SH_DYN_AIDS_DH" FLOAT, 
	"SH_DYN_AIDS_FE_ZS" FLOAT, 
	"SH_DYN_AIDS_ZS" FLOAT, 
	"SH_DYN_MORT" FLOAT, 
	"SH_DYN_MORT_FE" FLOAT, 
	"SH_DYN_MORT_MA" FLOAT, 
	"SH_DYN_NMRT" FLOAT, 
	"SH_FPL_SATI_ZS" FLOAT, 
	"SH_H2O_SAFE_RU_ZS" FLOAT, 
	"SH_H2O_SAFE_UR_ZS" FLOAT, 
	"SH_H2O_SAFE_ZS" FLOAT, 
	"SH_HIV_0014" FLOAT, 
	"SH_HIV_1524_FE_ZS" FLOAT, 
	"SH_HIV_1524_KW_FE_ZS" FLOAT, 
	"SH_HIV_1524_KW_MA_ZS" FLOAT, 
	"SH_HIV_1524_MA_ZS" FLOAT, 
	"SH_HIV_ARTC_ZS" FLOAT, 
	"SH_HIV_KNOW_FE_ZS" FLOAT, 
	"SH_HIV_KNOW_MA_ZS" FLOAT, 
	"SH_HIV_ORPH" FLOAT, 
	"SH_HIV_TOTL" FLOAT, 
	"SH_IMM_HEPB" FLOAT, 
	"SH_IMM_HIB3" FLOAT, 
	"SH_IMM_IBCG" FLOAT, 
	"SH_IMM_IDPT" FLOAT, 
	"SH_IMM_MEAS" FLOAT, 
	"SH_IMM_POL3" FLOAT, 
	"SH_MED_BEDS_ZS" FLOAT, 
	"SH_MED_CMHW_P3" FLOAT, 
	"SH_MED_NUMW_P3" FLOAT, 
	"SH_MED_PHYS_ZS" FLOAT, 
	"SH_MLR_NETS_ZS" FLOAT, 
	"SH_MLR_PREG_ZS" FLOAT, 
	"SH_MLR_SPF2_ZS" FLOAT, 
	"SH_MLR_TRET_ZS" FLOAT, 
	"SH_MMR_DTHS" FLOAT, 
	"SH_MMR_LEVE" FLOAT, 
	"SH_MMR_RISK" FLOAT, 
	"SH_MMR_RISK_ZS" FLOAT, 
	"SH_MMR_WAGE_ZS" FLOAT, 
	"SH_PRG_ANEM" FLOAT, 
	"SH_PRG_ARTC_ZS" FLOAT, 
	"SH_PRG_SYPH_ZS" FLOAT, 
	"SH_PRV_SMOK_FE" FLOAT, 
	"SH_PRV_SMOK_MA" FLOAT, 
	"SH_STA_ACSN" FLOAT, 
	"SH_STA_ACSN_RU" FLOAT, 
	"SH_STA_ACSN_UR" FLOAT, 
	"SH_STA_ANV4_ZS" FLOAT, 
	"SH_STA_ANVC_ZS" FLOAT, 
	"SH_STA_ARIC_ZS" FLOAT, 
	"SH_STA_BFED_ZS" FLOAT, 
	"SH_STA_BRTC_ZS" FLOAT, 
	"SH_STA_BRTW_ZS" FLOAT, 
	"SH_STA_DIAB_ZS" FLOAT, 
	"SH_STA_IYCF_ZS" FLOAT, 
	"SH_STA_MALN_FE_ZS" FLOAT, 
	"SH_STA_MALN_MA_ZS" FLOAT, 
	"SH_STA_MALN_ZS" FLOAT, 
	"SH_STA_MALR" FLOAT, 
	"SH_STA_MMRT" FLOAT, 
	"SH_STA_MMRT_NE" FLOAT, 
	"SH_STA_ORCF_ZS" FLOAT, 
	"SH_STA_ORTH" FLOAT, 
	"SH_STA_OW15_FE_ZS" FLOAT, 
	"SH_STA_OW15_MA_ZS" FLOAT, 
	"SH_STA_OW15_ZS" FLOAT, 
	"SH_STA_OWGH_FE_ZS" FLOAT, 
	"SH_STA_OWGH_MA_ZS" FLOAT, 
	"SH_STA_OWGH_ZS" FLOAT, 
	"SH_STA_PNVC_ZS" FLOAT, 
	"SH_STA_STNT_FE_ZS" FLOAT, 
	"SH_STA_STNT_MA_ZS" FLOAT, 
	"SH_STA_STNT_ZS" FLOAT, 
	"SH_STA_WAST_FE_ZS" FLOAT, 
	"SH_STA_WAST_MA_ZS" FLOAT, 
	"SH_STA_WAST_ZS" FLOAT, 
	"SH_SVR_WAST_FE_ZS" FLOAT, 
	"SH_SVR_WAST_MA_ZS" FLOAT, 
	"SH_SVR_WAST_ZS" FLOAT, 
	"SH_TBS_CURE_ZS" FLOAT, 
	"SH_TBS_DTEC_ZS" FLOAT, 
	"SH_TBS_INCD" FLOAT, 
	"SH_TBS_MORT" FLOAT, 
	"SH_TBS_PREV" FLOAT, 
	"SH_VAC_TTNS_ZS" FLOAT, 
	"SH_XPD_EXTR_ZS" FLOAT, 
	"SH_XPD_OOPC_TO_ZS" FLOAT, 
	"SH_XPD_OOPC_ZS" FLOAT, 
	"SH_XPD_PCAP" FLOAT, 
	"SH_XPD_PCAP_PP_KD" FLOAT, 
	"SH_XPD_PRIV" FLOAT, 
	"SH_XPD_PRIV_ZS" FLOAT, 
	"SH_XPD_PUBL" FLOAT, 
	"SH_XPD_PUBL_GX_ZS" FLOAT, 
	"SH_XPD_PUBL_ZS" FLOAT, 
	"SH_XPD_TOTL_CD" FLOAT, 
	"SH_XPD_TOTL_ZS" FLOAT, 
	"SI_POV_NAHC" FLOAT, 
	"SI_POV_RUHC" FLOAT, 
	"SI_POV_URHC" FLOAT, 
	"SL_EMP_INSV_FE_ZS" FLOAT, 
	"SL_TLF_TOTL_FE_ZS" FLOAT, 
	"SL_TLF_TOTL_IN" FLOAT, 
	"SL_UEM_TOTL_FE_ZS" FLOAT, 
	"SL_UEM_TOTL_MA_ZS" FLOAT, 
	"SL_UEM_TOTL_ZS" FLOAT, 
	"SM_POP_NETM" FLOAT, 
	"SN_ITK_DEFC" FLOAT, 
	"SN_ITK_DEFC_ZS" FLOAT, 
	"SN_ITK_SALT_ZS" FLOAT, 
	"SN_ITK_VITA_ZS" FLOAT, 
	"SP_ADO_TFRT" FLOAT, 
	"SP_DYN_AMRT_FE" FLOAT, 
	"SP_DYN_AMRT_MA" FLOAT, 
	"SP_DYN_CBRT_IN" FLOAT, 
	"SP_DYN_CDRT_IN" FLOAT, 
	"SP_DYN_CONU_ZS" FLOAT, 
	"SP_DYN_IMRT_FE_IN" FLOAT, 
	"SP_DYN_IMRT_IN" FLOAT, 
	"SP_DYN_IMRT_MA_IN" FLOAT, 
	"SP_DYN_LE00_FE_IN" FLOAT, 
	"SP_DYN_LE00_IN" FLOAT, 
	"SP_DYN_LE00_MA_IN" FLOAT, 
	"SP_DYN_SMAM_FE" FLOAT, 
	"SP_DYN_SMAM_MA" FLOAT, 
	"SP_DYN_TFRT_IN" FLOAT, 
	"SP_DYN_TO65_FE_ZS" FLOAT, 
	"SP_DYN_TO65_MA_ZS" FLOAT, 
	"SP_DYN_WFRT" FLOAT, 
	"SP_HOU_FEMA_ZS" FLOAT, 
	"SP_MTR_1519_ZS" FLOAT, 
	"SP_POP_0004_FE" FLOAT, 
	"SP_POP_0004_FE_5Y" FLOAT, 
	"SP_POP_0004_MA" FLOAT, 
	"SP_POP_0004_MA_5Y" FLOAT, 
	"SP_POP_0014_FE_ZS" FLOAT, 
	"SP_POP_0014_MA_ZS" FLOAT, 
	"SP_POP_0014_TO" FLOAT, 
	"SP_POP_0014_TO_ZS" FLOAT, 
	"SP_POP_0509_FE" FLOAT, 
	"SP_POP_0509_FE_5Y" FLOAT, 
	"SP_POP_0509_MA" FLOAT, 
	"SP_POP_0509_MA_5Y" FLOAT, 
	"SP_POP_1014_FE" FLOAT, 
	"SP_POP_1014_FE_5Y" FLOAT, 
	"SP_POP_1014_MA" FLOAT, 
	"SP_POP_1014_MA_5Y" FLOAT, 
	"SP_POP_1519_FE" FLOAT, 
	"SP_POP_1519_FE_5Y" FLOAT, 
	"SP_POP_1519_MA" FLOAT, 
	"SP_POP_1519_MA_5Y" FLOAT, 
	"SP_POP_1564_FE_ZS" FLOAT, 
	"SP_POP_1564_MA_ZS" FLOAT, 
	"SP_POP_1564_TO" FLOAT, 
	"SP_POP_1564_TO_ZS" FLOAT, 
	"SP_POP_2024_FE" FLOAT, 
	"SP_POP_2024_FE_5Y" FLOAT, 
	"SP_POP_2024_MA" FLOAT, 
	"SP_POP_2024_MA_5Y" FLOAT, 
	"SP_POP_2529_FE" FLOAT, 
	"SP_POP_2529_FE_5Y" FLOAT, 
	"SP_POP_2529_MA" FLOAT, 
	"SP_POP_2529_MA_5Y" FLOAT, 
	"SP_POP_3034_FE" FLOAT, 
	"SP_POP_3034_FE_5Y" FLOAT, 
	"SP_POP_3034_MA" FLOAT, 
	"SP_POP_3034_MA_5Y" FLOAT, 
	"SP_POP_3539_FE" FLOAT, 
	"SP_POP_3539_FE_5Y" FLOAT, 
	"SP_POP_3539_MA" FLOAT, 
	"SP_POP_3539_MA_5Y" FLOAT, 
	"SP_POP_4044_FE" FLOAT, 
	"SP_POP_4044_FE_5Y" FLOAT, 
	"SP_POP_4044_MA" FLOAT, 
	"SP_POP_4044_MA_5Y" FLOAT, 
	"SP_POP_4549_FE" FLOAT, 
	"SP_POP_4549_FE_5Y" FLOAT, 
	"SP_POP_4549_MA" FLOAT, 
	"SP_POP_4549_MA_5Y" FLOAT, 
	"SP_POP_5054_FE" FLOAT, 
	"SP_POP_5054_FE_5Y" FLOAT, 
	"SP_POP_5054_MA" FLOAT, 
	"SP_POP_5054_MA_5Y" FLOAT, 
	"SP_POP_5559_FE" FLOAT, 
	"SP_POP_5559_FE_5Y" FLOAT, 
	"SP_POP_5559_MA" FLOAT, 
	"SP_POP_5559_MA_5Y" FLOAT, 
	"SP_POP_6064_FE" FLOAT, 
	"SP_POP_6064_FE_5Y" FLOAT, 
	"SP_POP_6064_MA" FLOAT, 
	"SP_POP_6064_MA_5Y" FLOAT, 
	"SP_POP_6569_FE" FLOAT, 
	"SP_POP_6569_FE_5Y" FLOAT, 
	"SP_POP_6569_MA" FLOAT, 
	"SP_POP_6569_MA_5Y" FLOAT, 
	"SP_POP_65UP_FE_ZS" FLOAT, 
	"SP_POP_65UP_MA_ZS" FLOAT, 
	"SP_POP_65UP_TO" FLOAT, 
	"SP_POP_65UP_TO_ZS" FLOAT, 
	"SP_POP_7074_FE" FLOAT, 
	"SP_POP_7074_FE_5Y" FLOAT, 
	"SP_POP_7074_MA" FLOAT, 
	"SP_POP_7074_MA_5Y" FLOAT, 
	"SP_POP_7579_FE" FLOAT, 
	"SP_POP_7579_FE_5Y" FLOAT, 
	"SP_POP_7579_MA" FLOAT, 
	"SP_POP_7579_MA_5Y" FLOAT, 
	"SP_POP_80UP_FE" FLOAT, 
	"SP_POP_80UP_FE_5Y" FLOAT, 
	"SP_POP_80UP_MA" FLOAT, 
	"SP_POP_80UP_MA_5Y" FLOAT, 
	"SP_POP_AG00_FE_IN" FLOAT, 
	"SP_POP_AG00_MA_IN" FLOAT, 
	"SP_POP_AG01_FE_IN" FLOAT, 
	"SP_POP_AG01_MA_IN" FLOAT, 
	"SP_POP_AG02_FE_IN" FLOAT, 
	"SP_POP_AG02_MA_IN" FLOAT, 
	"SP_POP_AG03_FE_IN" FLOAT, 
	"SP_POP_AG03_MA_IN" FLOAT, 
	"SP_POP_AG04_FE_IN" FLOAT, 
	"SP_POP_AG04_MA_IN" FLOAT, 
	"SP_POP_AG05_FE_IN" FLOAT, 
	"SP_POP_AG05_MA_IN" FLOAT, 
	"SP_POP_AG06_FE_IN" FLOAT, 
	"SP_POP_AG06_MA_IN" FLOAT, 
	"SP_POP_AG07_FE_IN" FLOAT, 
	"SP_POP_AG07_MA_IN" FLOAT, 
	"SP_POP_AG08_FE_IN" FLOAT, 
	"SP_POP_AG08_MA_IN" FLOAT, 
	"SP_POP_AG09_FE_IN" FLOAT, 
	"SP_POP_AG09_MA_IN" FLOAT, 
	"SP_POP_AG10_FE_IN" FLOAT, 
	"SP_POP_AG10_MA_IN" FLOAT, 
	"SP_POP_AG11_FE_IN" FLOAT, 
	"SP_POP_AG11_MA_IN" FLOAT, 
	"SP_POP_AG12_FE_IN" FLOAT, 
	"SP_POP_AG12_MA_IN" FLOAT, 
	"SP_POP_AG13_FE_IN" FLOAT, 
	"SP_POP_AG13_MA_IN" FLOAT, 
	"SP_POP_AG14_FE_IN" FLOAT, 
	"SP_POP_AG14_MA_IN" FLOAT, 
	"SP_POP_AG15_FE_IN" FLOAT, 
	"SP_POP_AG15_MA_IN" FLOAT, 
	"SP_POP_AG16_FE_IN" FLOAT, 
	"SP_POP_AG16_MA_IN" FLOAT, 
	"SP_POP_AG17_FE_IN" FLOAT, 
	"SP_POP_AG17_MA_IN" FLOAT, 
	"SP_POP_AG18_FE_IN" FLOAT, 
	"SP_POP_AG18_MA_IN" FLOAT, 
	"SP_POP_AG19_FE_IN" FLOAT, 
	"SP_POP_AG19_MA_IN" FLOAT, 
	"SP_POP_AG20_FE_IN" FLOAT, 
	"SP_POP_AG20_MA_IN" FLOAT, 
	"SP_POP_AG21_FE_IN" FLOAT, 
	"SP_POP_AG21_MA_IN" FLOAT, 
	"SP_POP_AG22_FE_IN" FLOAT, 
	"SP_POP_AG22_MA_IN" FLOAT, 
	"SP_POP_AG23_FE_IN" FLOAT, 
	"SP_POP_AG23_MA_IN" FLOAT, 
	"SP_POP_AG24_FE_IN" FLOAT, 
	"SP_POP_AG24_MA_IN" FLOAT, 
	"SP_POP_AG25_FE_IN" FLOAT, 
	"SP_POP_AG25_MA_IN" FLOAT, 
	"SP_POP_BRTH_MF" FLOAT, 
	"SP_POP_DPND" FLOAT, 
	"SP_POP_DPND_OL" FLOAT, 
	"SP_POP_DPND_YG" FLOAT, 
	"SP_POP_GROW" FLOAT, 
	"SP_POP_TOTL" FLOAT, 
	"SP_POP_TOTL_FE_IN" FLOAT, 
	"SP_POP_TOTL_FE_ZS" FLOAT, 
	"SP_POP_TOTL_MA_IN" FLOAT, 
	"SP_POP_TOTL_MA_ZS" FLOAT, 
	"SP_REG_BRTH_RU_ZS" FLOAT, 
	"SP_REG_BRTH_UR_ZS" FLOAT, 
	"SP_REG_BRTH_ZS" FLOAT, 
	"SP_REG_DTHS_ZS" FLOAT, 
	"SP_RUR_TOTL" FLOAT, 
	"SP_RUR_TOTL_ZG" FLOAT, 
	"SP_RUR_TOTL_ZS" FLOAT, 
	"SP_URB_GROW" FLOAT, 
	"SP_URB_TOTL" FLOAT, 
	"SP_URB_TOTL_IN_ZS" FLOAT, 
	"SP_UWT_TFRT" FLOAT, 
	country_code VARCHAR(3), 
	country_name VARCHAR(255), 
	region VARCHAR(255), 
	year DATETIME
);
DROP TABLE IF EXISTS `birth_names` ;
CREATE TABLE IF NOT EXISTS `birth_names` (

	ds DATETIME, 
	gender VARCHAR(16), 
	name VARCHAR(255), 
	num BIGINT, 
	state VARCHAR(10), 
	sum_boys BIGINT, 
	sum_girls BIGINT
);
DROP TABLE IF EXISTS `random_time_series` ;
CREATE TABLE IF NOT EXISTS `random_time_series` (

	ds DATETIME
);
DROP TABLE IF EXISTS `long_lat` ;
CREATE TABLE IF NOT EXISTS `long_lat` (

	"LON" FLOAT, 
	"LAT" FLOAT, 
	"NUMBER" TEXT, 
	"STREET" TEXT, 
	"UNIT" TEXT, 
	"CITY" FLOAT, 
	"DISTRICT" FLOAT, 
	"REGION" FLOAT, 
	"POSTCODE" BIGINT, 
	"ID" FLOAT, 
	date DATE, 
	occupancy FLOAT, 
	radius_miles FLOAT
);
DROP TABLE IF EXISTS `multiformat_time_series` ;
CREATE TABLE IF NOT EXISTS `multiformat_time_series` (

	ds DATE, 
	ds2 DATETIME, 
	epoch_ms BIGINT, 
	epoch_s BIGINT, 
	string0 VARCHAR(100), 
	string1 VARCHAR(100), 
	string2 VARCHAR(100), 
	string3 VARCHAR(100)
);
CREATE INDEX ti_user_id_changed_on ON `query` (user_id, changed_on);
