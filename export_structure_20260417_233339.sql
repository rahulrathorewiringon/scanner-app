--
-- PostgreSQL database dump
--

\restrict iqNqmBP406CICgKrXbgK7ky3L5E6wGsmebYf7jguEYP305WTCPR5eeXiz5TIADx

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: bfo_exchange_symbol; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA bfo_exchange_symbol;


ALTER SCHEMA bfo_exchange_symbol OWNER TO rathore;

--
-- Name: bse_exchange_symbol; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA bse_exchange_symbol;


ALTER SCHEMA bse_exchange_symbol OWNER TO rathore;

--
-- Name: cds_exchange_symbol; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA cds_exchange_symbol;


ALTER SCHEMA cds_exchange_symbol OWNER TO rathore;

--
-- Name: charting; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA charting;


ALTER SCHEMA charting OWNER TO rathore;

--
-- Name: core_app_mcx; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA core_app_mcx;


ALTER SCHEMA core_app_mcx OWNER TO rathore;

--
-- Name: core_app_nfo; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA core_app_nfo;


ALTER SCHEMA core_app_nfo OWNER TO rathore;

--
-- Name: core_app_nse; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA core_app_nse;


ALTER SCHEMA core_app_nse OWNER TO rathore;

--
-- Name: exchange; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA exchange;


ALTER SCHEMA exchange OWNER TO rathore;

--
-- Name: exchange_symbol; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA exchange_symbol;


ALTER SCHEMA exchange_symbol OWNER TO rathore;

--
-- Name: ingestion; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA ingestion;


ALTER SCHEMA ingestion OWNER TO rathore;

--
-- Name: market_intelligence; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA market_intelligence;


ALTER SCHEMA market_intelligence OWNER TO rathore;

--
-- Name: market_mcx; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA market_mcx;


ALTER SCHEMA market_mcx OWNER TO rathore;

--
-- Name: market_nfo; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA market_nfo;


ALTER SCHEMA market_nfo OWNER TO rathore;

--
-- Name: market_nse; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA market_nse;


ALTER SCHEMA market_nse OWNER TO rathore;

--
-- Name: mcx_exchange_symbol; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA mcx_exchange_symbol;


ALTER SCHEMA mcx_exchange_symbol OWNER TO rathore;

--
-- Name: mcx_tick_data; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA mcx_tick_data;


ALTER SCHEMA mcx_tick_data OWNER TO rathore;

--
-- Name: meta_data; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA meta_data;


ALTER SCHEMA meta_data OWNER TO rathore;

--
-- Name: metadata; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA metadata;


ALTER SCHEMA metadata OWNER TO rathore;

--
-- Name: nfo_exchange_symbol; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA nfo_exchange_symbol;


ALTER SCHEMA nfo_exchange_symbol OWNER TO rathore;

--
-- Name: nfo_tick_data; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA nfo_tick_data;


ALTER SCHEMA nfo_tick_data OWNER TO rathore;

--
-- Name: nse_exchange_symbol; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA nse_exchange_symbol;


ALTER SCHEMA nse_exchange_symbol OWNER TO rathore;

--
-- Name: nse_tick_data; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA nse_tick_data;


ALTER SCHEMA nse_tick_data OWNER TO rathore;

--
-- Name: signals_mcx; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA signals_mcx;


ALTER SCHEMA signals_mcx OWNER TO rathore;

--
-- Name: signals_nfo; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA signals_nfo;


ALTER SCHEMA signals_nfo OWNER TO rathore;

--
-- Name: signals_nse; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA signals_nse;


ALTER SCHEMA signals_nse OWNER TO rathore;

--
-- Name: staging; Type: SCHEMA; Schema: -; Owner: rathore
--

CREATE SCHEMA staging;


ALTER SCHEMA staging OWNER TO rathore;

--
-- Name: acceleration_state_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.acceleration_state_enum AS ENUM (
    'ACCELERATING',
    'DECELERATING',
    'STABLE',
    'UNKNOWN'
);


ALTER TYPE public.acceleration_state_enum OWNER TO rathore;

--
-- Name: angle_label_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.angle_label_enum AS ENUM (
    'STEEP_UP',
    'UP',
    'FLAT',
    'DOWN',
    'STEEP_DOWN',
    'UNKNOWN'
);


ALTER TYPE public.angle_label_enum OWNER TO rathore;

--
-- Name: bar_status_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.bar_status_enum AS ENUM (
    'LIVE_PARTIAL',
    'SESSION_FINAL',
    'FINAL',
    'EOD_RECONCILED'
);


ALTER TYPE public.bar_status_enum OWNER TO rathore;

--
-- Name: cross_direction_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.cross_direction_enum AS ENUM (
    'BULL_CROSS',
    'BEAR_CROSS',
    'NO_CROSS'
);


ALTER TYPE public.cross_direction_enum OWNER TO rathore;

--
-- Name: pivot_type_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.pivot_type_enum AS ENUM (
    'PH',
    'PL',
    'LPH',
    'LPL'
);


ALTER TYPE public.pivot_type_enum OWNER TO rathore;

--
-- Name: recent_vs_overall_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.recent_vs_overall_enum AS ENUM (
    'INTENSIFYING',
    'FADING',
    'ALIGNED',
    'UNKNOWN'
);


ALTER TYPE public.recent_vs_overall_enum OWNER TO rathore;

--
-- Name: sma_compression_state_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.sma_compression_state_enum AS ENUM (
    'COMPRESSED',
    'EXPANDING',
    'NEUTRAL'
);


ALTER TYPE public.sma_compression_state_enum OWNER TO rathore;

--
-- Name: sma_order_structure_state_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.sma_order_structure_state_enum AS ENUM (
    'BULL_STACK',
    'BEAR_STACK',
    'MIXED',
    'PARTIAL'
);


ALTER TYPE public.sma_order_structure_state_enum OWNER TO rathore;

--
-- Name: sma_position_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.sma_position_enum AS ENUM (
    'GH',
    'GHL',
    'GL',
    'RH',
    'RHL',
    'RL'
);


ALTER TYPE public.sma_position_enum OWNER TO rathore;

--
-- Name: timeframe_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.timeframe_enum AS ENUM (
    'hour',
    'day',
    'week',
    'month'
);


ALTER TYPE public.timeframe_enum OWNER TO rathore;

--
-- Name: trend_direction_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.trend_direction_enum AS ENUM (
    'UP',
    'DOWN',
    'FLAT',
    'UNKNOWN'
);


ALTER TYPE public.trend_direction_enum OWNER TO rathore;

--
-- Name: trend_pivot_type_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.trend_pivot_type_enum AS ENUM (
    'HH',
    'LH',
    'HL',
    'LL',
    'LHH',
    'LLH',
    'LHL',
    'LLL'
);


ALTER TYPE public.trend_pivot_type_enum OWNER TO rathore;

--
-- Name: turn_direction_enum; Type: TYPE; Schema: public; Owner: rathore
--

CREATE TYPE public.turn_direction_enum AS ENUM (
    'UP',
    'DOWN',
    'FLAT',
    'UNKNOWN'
);


ALTER TYPE public.turn_direction_enum OWNER TO rathore;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: instrument_master; Type: TABLE; Schema: bfo_exchange_symbol; Owner: rathore
--

CREATE TABLE bfo_exchange_symbol.instrument_master (
    instrument_id bigint NOT NULL,
    instrument_key text NOT NULL,
    symbol text NOT NULL,
    trading_symbol text,
    instrument_type text NOT NULL,
    asset_class text DEFAULT 'DERIVATIVE'::text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    tick_size numeric(18,8),
    lot_size integer,
    currency_code text DEFAULT 'INR'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE bfo_exchange_symbol.instrument_master OWNER TO rathore;

--
-- Name: instrument_master_derivative; Type: TABLE; Schema: bfo_exchange_symbol; Owner: rathore
--

CREATE TABLE bfo_exchange_symbol.instrument_master_derivative (
    instrument_id bigint NOT NULL,
    bse_underlying_instrument_id bigint,
    token text,
    expiry_date date,
    option_type text,
    strike_price numeric(18,4),
    settlement_type text,
    underlying_symbol text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE bfo_exchange_symbol.instrument_master_derivative OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE; Schema: bfo_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE bfo_exchange_symbol.instrument_master_instrument_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE bfo_exchange_symbol.instrument_master_instrument_id_seq OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: bfo_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE bfo_exchange_symbol.instrument_master_instrument_id_seq OWNED BY bfo_exchange_symbol.instrument_master.instrument_id;


--
-- Name: phase0_run_audit; Type: TABLE; Schema: bfo_exchange_symbol; Owner: rathore
--

CREATE TABLE bfo_exchange_symbol.phase0_run_audit (
    run_id bigint NOT NULL,
    step_code text NOT NULL,
    status text NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    rows_inserted integer DEFAULT 0 NOT NULL,
    rows_updated integer DEFAULT 0 NOT NULL,
    rows_rejected integer DEFAULT 0 NOT NULL,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    error_message text
);


ALTER TABLE bfo_exchange_symbol.phase0_run_audit OWNER TO rathore;

--
-- Name: phase0_run_audit_run_id_seq; Type: SEQUENCE; Schema: bfo_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE bfo_exchange_symbol.phase0_run_audit_run_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE bfo_exchange_symbol.phase0_run_audit_run_id_seq OWNER TO rathore;

--
-- Name: phase0_run_audit_run_id_seq; Type: SEQUENCE OWNED BY; Schema: bfo_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE bfo_exchange_symbol.phase0_run_audit_run_id_seq OWNED BY bfo_exchange_symbol.phase0_run_audit.run_id;


--
-- Name: instrument_all_time_levels; Type: TABLE; Schema: bse_exchange_symbol; Owner: rathore
--

CREATE TABLE bse_exchange_symbol.instrument_all_time_levels (
    instrument_id bigint NOT NULL,
    level_type character varying(10) NOT NULL,
    price numeric(20,4) NOT NULL,
    level_date timestamp without time zone NOT NULL,
    recorded_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE bse_exchange_symbol.instrument_all_time_levels OWNER TO rathore;

--
-- Name: instrument_chart_bootstrap; Type: TABLE; Schema: bse_exchange_symbol; Owner: rathore
--

CREATE TABLE bse_exchange_symbol.instrument_chart_bootstrap (
    bootstrap_id bigint NOT NULL,
    instrument_id bigint NOT NULL,
    chart_data_required boolean DEFAULT false NOT NULL,
    chart_data_exists boolean DEFAULT false NOT NULL,
    bootstrap_status text DEFAULT 'PLACEHOLDER'::text NOT NULL,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE bse_exchange_symbol.instrument_chart_bootstrap OWNER TO rathore;

--
-- Name: instrument_chart_bootstrap_bootstrap_id_seq; Type: SEQUENCE; Schema: bse_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE bse_exchange_symbol.instrument_chart_bootstrap_bootstrap_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE bse_exchange_symbol.instrument_chart_bootstrap_bootstrap_id_seq OWNER TO rathore;

--
-- Name: instrument_chart_bootstrap_bootstrap_id_seq; Type: SEQUENCE OWNED BY; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE bse_exchange_symbol.instrument_chart_bootstrap_bootstrap_id_seq OWNED BY bse_exchange_symbol.instrument_chart_bootstrap.bootstrap_id;


--
-- Name: instrument_master; Type: TABLE; Schema: bse_exchange_symbol; Owner: rathore
--

CREATE TABLE bse_exchange_symbol.instrument_master (
    instrument_id bigint NOT NULL,
    instrument_key text NOT NULL,
    symbol text NOT NULL,
    trading_symbol text,
    instrument_type text NOT NULL,
    asset_class text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    tick_size numeric(18,8),
    lot_size integer,
    face_value numeric(18,4),
    currency_code text DEFAULT 'INR'::text NOT NULL,
    first_seen_date date,
    last_seen_date date,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE bse_exchange_symbol.instrument_master OWNER TO rathore;

--
-- Name: instrument_master_equity; Type: TABLE; Schema: bse_exchange_symbol; Owner: rathore
--

CREATE TABLE bse_exchange_symbol.instrument_master_equity (
    instrument_id bigint NOT NULL,
    company_name text,
    isin text,
    sector text,
    industry text,
    market_cap_bucket text,
    index_member_flag boolean DEFAULT false NOT NULL,
    token text,
    series text,
    code text,
    canonical_symbol text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE bse_exchange_symbol.instrument_master_equity OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE; Schema: bse_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE bse_exchange_symbol.instrument_master_instrument_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE bse_exchange_symbol.instrument_master_instrument_id_seq OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE bse_exchange_symbol.instrument_master_instrument_id_seq OWNED BY bse_exchange_symbol.instrument_master.instrument_id;


--
-- Name: phase0_run_audit; Type: TABLE; Schema: bse_exchange_symbol; Owner: rathore
--

CREATE TABLE bse_exchange_symbol.phase0_run_audit (
    run_id bigint NOT NULL,
    step_code text NOT NULL,
    status text NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    rows_inserted integer DEFAULT 0 NOT NULL,
    rows_updated integer DEFAULT 0 NOT NULL,
    rows_rejected integer DEFAULT 0 NOT NULL,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    error_message text
);


ALTER TABLE bse_exchange_symbol.phase0_run_audit OWNER TO rathore;

--
-- Name: phase0_run_audit_run_id_seq; Type: SEQUENCE; Schema: bse_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE bse_exchange_symbol.phase0_run_audit_run_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE bse_exchange_symbol.phase0_run_audit_run_id_seq OWNER TO rathore;

--
-- Name: phase0_run_audit_run_id_seq; Type: SEQUENCE OWNED BY; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE bse_exchange_symbol.phase0_run_audit_run_id_seq OWNED BY bse_exchange_symbol.phase0_run_audit.run_id;


--
-- Name: instrument_master; Type: TABLE; Schema: cds_exchange_symbol; Owner: rathore
--

CREATE TABLE cds_exchange_symbol.instrument_master (
    instrument_id bigint NOT NULL,
    instrument_key text NOT NULL,
    symbol text NOT NULL,
    trading_symbol text,
    instrument_type text NOT NULL,
    asset_class text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    tick_size numeric(18,8),
    lot_size integer,
    currency_code text DEFAULT 'INR'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE cds_exchange_symbol.instrument_master OWNER TO rathore;

--
-- Name: instrument_master_derivative; Type: TABLE; Schema: cds_exchange_symbol; Owner: rathore
--

CREATE TABLE cds_exchange_symbol.instrument_master_derivative (
    instrument_id bigint NOT NULL,
    token text,
    expiry_date date,
    option_type text,
    strike_price numeric(18,6),
    underlying_symbol text,
    "precision" integer,
    multiplier integer,
    exchange_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE cds_exchange_symbol.instrument_master_derivative OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE; Schema: cds_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE cds_exchange_symbol.instrument_master_instrument_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE cds_exchange_symbol.instrument_master_instrument_id_seq OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: cds_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE cds_exchange_symbol.instrument_master_instrument_id_seq OWNED BY cds_exchange_symbol.instrument_master.instrument_id;


--
-- Name: phase0_run_audit; Type: TABLE; Schema: cds_exchange_symbol; Owner: rathore
--

CREATE TABLE cds_exchange_symbol.phase0_run_audit (
    run_id bigint NOT NULL,
    step_code text NOT NULL,
    status text NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    rows_inserted integer DEFAULT 0 NOT NULL,
    rows_updated integer DEFAULT 0 NOT NULL,
    rows_rejected integer DEFAULT 0 NOT NULL,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    error_message text
);


ALTER TABLE cds_exchange_symbol.phase0_run_audit OWNER TO rathore;

--
-- Name: phase0_run_audit_run_id_seq; Type: SEQUENCE; Schema: cds_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE cds_exchange_symbol.phase0_run_audit_run_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE cds_exchange_symbol.phase0_run_audit_run_id_seq OWNER TO rathore;

--
-- Name: phase0_run_audit_run_id_seq; Type: SEQUENCE OWNED BY; Schema: cds_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE cds_exchange_symbol.phase0_run_audit_run_id_seq OWNED BY cds_exchange_symbol.phase0_run_audit.run_id;


--
-- Name: instrument_master; Type: TABLE; Schema: exchange_symbol; Owner: rathore
--

CREATE TABLE exchange_symbol.instrument_master (
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    instrument_key text NOT NULL,
    symbol text NOT NULL,
    trading_symbol text,
    instrument_type text NOT NULL,
    asset_class text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    tick_size numeric(18,8),
    lot_size integer,
    face_value numeric(18,4),
    currency_code text DEFAULT 'INR'::text NOT NULL,
    first_seen_date date,
    last_seen_date date,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    source_entity_type text,
    source_entity_id bigint
);


ALTER TABLE exchange_symbol.instrument_master OWNER TO rathore;

--
-- Name: market_candle; Type: TABLE; Schema: market_mcx; Owner: rathore
--

CREATE TABLE market_mcx.market_candle (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    bar_end_ts timestamp without time zone NOT NULL,
    trade_date date NOT NULL,
    candle_week date,
    session_bar_seq integer,
    open numeric(18,6) NOT NULL,
    high numeric(18,6) NOT NULL,
    low numeric(18,6) NOT NULL,
    close numeric(18,6) NOT NULL,
    volume numeric(20,4),
    open_interest numeric(20,4),
    source_name text NOT NULL,
    source_priority integer DEFAULT 100 NOT NULL,
    bar_status public.bar_status_enum DEFAULT 'FINAL'::public.bar_status_enum NOT NULL,
    is_eod_reconciled boolean DEFAULT false NOT NULL,
    revision_no integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE market_mcx.market_candle OWNER TO rathore;

--
-- Name: market_candle_feature_fast; Type: TABLE; Schema: market_mcx; Owner: rathore
--

CREATE TABLE market_mcx.market_candle_feature_fast (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    sma_5 numeric(18,6),
    sma_10 numeric(18,6),
    sma_20 numeric(18,6),
    sma_50 numeric(18,6),
    sma_100 numeric(18,6),
    sma_200 numeric(18,6),
    atr_5 numeric(18,6),
    atr_14 numeric(18,6),
    atr_20 numeric(18,6),
    rsi_14 numeric(18,6),
    macd_line numeric(18,6),
    macd_signal numeric(18,6),
    macd_hist numeric(18,6),
    bb_mid numeric(18,6),
    bb_upper numeric(18,6),
    bb_lower numeric(18,6),
    bb_width numeric(18,6),
    rolling_vwap_20 numeric(18,6),
    obv numeric(20,4),
    volume_ma_20 numeric(20,4),
    rel_volume numeric(18,6),
    range_to_atr numeric(18,6),
    body_pct numeric(18,6),
    upper_wick_pct numeric(18,6),
    lower_wick_pct numeric(18,6)
);


ALTER TABLE market_mcx.market_candle_feature_fast OWNER TO rathore;

--
-- Name: market_candle_pivot; Type: TABLE; Schema: market_mcx; Owner: rathore
--

CREATE TABLE market_mcx.market_candle_pivot (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    pivot_type public.pivot_type_enum,
    pivot_confirmed boolean DEFAULT false NOT NULL,
    pivot_price numeric(18,6),
    pivot_left_arm_length integer,
    pivot_right_arm_length integer,
    pivot_left_arm_strength integer,
    pivot_right_arm_strength integer,
    trend_pivot_type public.trend_pivot_type_enum,
    trend_left_arm_length integer,
    trend_right_arm_length integer,
    trend_left_arm_strength integer,
    trend_right_arm_strength integer
);


ALTER TABLE market_mcx.market_candle_pivot OWNER TO rathore;

--
-- Name: market_candle; Type: TABLE; Schema: market_nfo; Owner: rathore
--

CREATE TABLE market_nfo.market_candle (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    bar_end_ts timestamp without time zone NOT NULL,
    trade_date date NOT NULL,
    candle_week date,
    session_bar_seq integer,
    open numeric(18,6) NOT NULL,
    high numeric(18,6) NOT NULL,
    low numeric(18,6) NOT NULL,
    close numeric(18,6) NOT NULL,
    volume numeric(20,4),
    open_interest numeric(20,4),
    source_name text NOT NULL,
    source_priority integer DEFAULT 100 NOT NULL,
    bar_status public.bar_status_enum DEFAULT 'FINAL'::public.bar_status_enum NOT NULL,
    is_eod_reconciled boolean DEFAULT false NOT NULL,
    revision_no integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE market_nfo.market_candle OWNER TO rathore;

--
-- Name: market_candle_feature_fast; Type: TABLE; Schema: market_nfo; Owner: rathore
--

CREATE TABLE market_nfo.market_candle_feature_fast (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    sma_5 numeric(18,6),
    sma_10 numeric(18,6),
    sma_20 numeric(18,6),
    sma_50 numeric(18,6),
    sma_100 numeric(18,6),
    sma_200 numeric(18,6),
    atr_5 numeric(18,6),
    atr_14 numeric(18,6),
    atr_20 numeric(18,6),
    rsi_14 numeric(18,6),
    macd_line numeric(18,6),
    macd_signal numeric(18,6),
    macd_hist numeric(18,6),
    bb_mid numeric(18,6),
    bb_upper numeric(18,6),
    bb_lower numeric(18,6),
    bb_width numeric(18,6),
    rolling_vwap_20 numeric(18,6),
    obv numeric(20,4),
    volume_ma_20 numeric(20,4),
    rel_volume numeric(18,6),
    range_to_atr numeric(18,6),
    body_pct numeric(18,6),
    upper_wick_pct numeric(18,6),
    lower_wick_pct numeric(18,6)
);


ALTER TABLE market_nfo.market_candle_feature_fast OWNER TO rathore;

--
-- Name: market_candle_pivot; Type: TABLE; Schema: market_nfo; Owner: rathore
--

CREATE TABLE market_nfo.market_candle_pivot (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    pivot_type public.pivot_type_enum,
    pivot_confirmed boolean DEFAULT false NOT NULL,
    pivot_price numeric(18,6),
    pivot_left_arm_length integer,
    pivot_right_arm_length integer,
    pivot_left_arm_strength integer,
    pivot_right_arm_strength integer,
    trend_pivot_type public.trend_pivot_type_enum,
    trend_left_arm_length integer,
    trend_right_arm_length integer,
    trend_left_arm_strength integer,
    trend_right_arm_strength integer
);


ALTER TABLE market_nfo.market_candle_pivot OWNER TO rathore;

--
-- Name: market_candle; Type: TABLE; Schema: market_nse; Owner: rathore
--

CREATE TABLE market_nse.market_candle (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    bar_end_ts timestamp without time zone NOT NULL,
    trade_date date NOT NULL,
    candle_week date,
    session_bar_seq integer,
    open numeric(18,6) NOT NULL,
    high numeric(18,6) NOT NULL,
    low numeric(18,6) NOT NULL,
    close numeric(18,6) NOT NULL,
    volume numeric(20,4),
    open_interest numeric(20,4),
    source_name text NOT NULL,
    source_priority integer DEFAULT 100 NOT NULL,
    bar_status public.bar_status_enum DEFAULT 'FINAL'::public.bar_status_enum NOT NULL,
    is_eod_reconciled boolean DEFAULT false NOT NULL,
    revision_no integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE market_nse.market_candle OWNER TO rathore;

--
-- Name: market_candle_feature_fast; Type: TABLE; Schema: market_nse; Owner: rathore
--

CREATE TABLE market_nse.market_candle_feature_fast (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    sma_5 numeric(18,6),
    sma_10 numeric(18,6),
    sma_20 numeric(18,6),
    sma_50 numeric(18,6),
    sma_100 numeric(18,6),
    sma_200 numeric(18,6),
    atr_5 numeric(18,6),
    atr_14 numeric(18,6),
    atr_20 numeric(18,6),
    rsi_14 numeric(18,6),
    macd_line numeric(18,6),
    macd_signal numeric(18,6),
    macd_hist numeric(18,6),
    bb_mid numeric(18,6),
    bb_upper numeric(18,6),
    bb_lower numeric(18,6),
    bb_width numeric(18,6),
    rolling_vwap_20 numeric(18,6),
    obv numeric(20,4),
    volume_ma_20 numeric(20,4),
    rel_volume numeric(18,6),
    range_to_atr numeric(18,6),
    body_pct numeric(18,6),
    upper_wick_pct numeric(18,6),
    lower_wick_pct numeric(18,6)
);


ALTER TABLE market_nse.market_candle_feature_fast OWNER TO rathore;

--
-- Name: market_candle_pivot; Type: TABLE; Schema: market_nse; Owner: rathore
--

CREATE TABLE market_nse.market_candle_pivot (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    pivot_type public.pivot_type_enum,
    pivot_confirmed boolean DEFAULT false NOT NULL,
    pivot_price numeric(18,6),
    pivot_left_arm_length integer,
    pivot_right_arm_length integer,
    pivot_left_arm_strength integer,
    pivot_right_arm_strength integer,
    trend_pivot_type public.trend_pivot_type_enum,
    trend_left_arm_length integer,
    trend_right_arm_length integer,
    trend_left_arm_strength integer,
    trend_right_arm_strength integer
);


ALTER TABLE market_nse.market_candle_pivot OWNER TO rathore;

--
-- Name: instrument_chart_snapshot_day; Type: MATERIALIZED VIEW; Schema: charting; Owner: rathore
--

CREATE MATERIALIZED VIEW charting.instrument_chart_snapshot_day AS
 SELECT im.exchange_code,
    im.symbol,
    im.trading_symbol,
    mc.instrument_id,
    (mc.timeframe)::text AS timeframe,
    mc.tf_id,
    mc.bar_start_ts AS date,
    mc.candle_week,
    mc.trade_date AS candle_date,
    (mc.bar_start_ts)::time without time zone AS candle_time,
    mc.open,
    mc.high,
    mc.low,
    mc.close,
    ff.sma_5,
    ff.sma_10,
    ff.sma_20,
    ff.sma_50,
    ff.sma_100,
    ff.sma_200,
    ff.atr_5,
    mc.volume,
    p.pivot_type,
    p.pivot_left_arm_length,
    p.pivot_right_arm_length,
    p.pivot_left_arm_strength,
    p.pivot_right_arm_strength,
    p.trend_pivot_type,
    p.trend_left_arm_length,
    p.trend_right_arm_length,
    p.trend_left_arm_strength,
    p.trend_right_arm_strength,
    ff.range_to_atr,
    ff.body_pct,
    ff.upper_wick_pct,
    ff.lower_wick_pct
   FROM (((market_nse.market_candle mc
     JOIN exchange_symbol.instrument_master im ON ((im.instrument_id = mc.instrument_id)))
     LEFT JOIN market_nse.market_candle_feature_fast ff ON (((ff.instrument_id = mc.instrument_id) AND (ff.timeframe = mc.timeframe) AND (ff.bar_start_ts = mc.bar_start_ts))))
     LEFT JOIN market_nse.market_candle_pivot p ON (((p.instrument_id = mc.instrument_id) AND (p.timeframe = mc.timeframe) AND (p.bar_start_ts = mc.bar_start_ts))))
  WHERE (mc.timeframe = 'day'::public.timeframe_enum)
UNION ALL
 SELECT im.exchange_code,
    im.symbol,
    im.trading_symbol,
    mc.instrument_id,
    (mc.timeframe)::text AS timeframe,
    mc.tf_id,
    mc.bar_start_ts AS date,
    mc.candle_week,
    mc.trade_date AS candle_date,
    (mc.bar_start_ts)::time without time zone AS candle_time,
    mc.open,
    mc.high,
    mc.low,
    mc.close,
    ff.sma_5,
    ff.sma_10,
    ff.sma_20,
    ff.sma_50,
    ff.sma_100,
    ff.sma_200,
    ff.atr_5,
    mc.volume,
    p.pivot_type,
    p.pivot_left_arm_length,
    p.pivot_right_arm_length,
    p.pivot_left_arm_strength,
    p.pivot_right_arm_strength,
    p.trend_pivot_type,
    p.trend_left_arm_length,
    p.trend_right_arm_length,
    p.trend_left_arm_strength,
    p.trend_right_arm_strength,
    ff.range_to_atr,
    ff.body_pct,
    ff.upper_wick_pct,
    ff.lower_wick_pct
   FROM (((market_nfo.market_candle mc
     JOIN exchange_symbol.instrument_master im ON ((im.instrument_id = mc.instrument_id)))
     LEFT JOIN market_nfo.market_candle_feature_fast ff ON (((ff.instrument_id = mc.instrument_id) AND (ff.timeframe = mc.timeframe) AND (ff.bar_start_ts = mc.bar_start_ts))))
     LEFT JOIN market_nfo.market_candle_pivot p ON (((p.instrument_id = mc.instrument_id) AND (p.timeframe = mc.timeframe) AND (p.bar_start_ts = mc.bar_start_ts))))
  WHERE (mc.timeframe = 'day'::public.timeframe_enum)
UNION ALL
 SELECT im.exchange_code,
    im.symbol,
    im.trading_symbol,
    mc.instrument_id,
    (mc.timeframe)::text AS timeframe,
    mc.tf_id,
    mc.bar_start_ts AS date,
    mc.candle_week,
    mc.trade_date AS candle_date,
    (mc.bar_start_ts)::time without time zone AS candle_time,
    mc.open,
    mc.high,
    mc.low,
    mc.close,
    ff.sma_5,
    ff.sma_10,
    ff.sma_20,
    ff.sma_50,
    ff.sma_100,
    ff.sma_200,
    ff.atr_5,
    mc.volume,
    p.pivot_type,
    p.pivot_left_arm_length,
    p.pivot_right_arm_length,
    p.pivot_left_arm_strength,
    p.pivot_right_arm_strength,
    p.trend_pivot_type,
    p.trend_left_arm_length,
    p.trend_right_arm_length,
    p.trend_left_arm_strength,
    p.trend_right_arm_strength,
    ff.range_to_atr,
    ff.body_pct,
    ff.upper_wick_pct,
    ff.lower_wick_pct
   FROM (((market_mcx.market_candle mc
     JOIN exchange_symbol.instrument_master im ON ((im.instrument_id = mc.instrument_id)))
     LEFT JOIN market_mcx.market_candle_feature_fast ff ON (((ff.instrument_id = mc.instrument_id) AND (ff.timeframe = mc.timeframe) AND (ff.bar_start_ts = mc.bar_start_ts))))
     LEFT JOIN market_mcx.market_candle_pivot p ON (((p.instrument_id = mc.instrument_id) AND (p.timeframe = mc.timeframe) AND (p.bar_start_ts = mc.bar_start_ts))))
  WHERE (mc.timeframe = 'day'::public.timeframe_enum)
  WITH NO DATA;


ALTER MATERIALIZED VIEW charting.instrument_chart_snapshot_day OWNER TO rathore;

--
-- Name: instrument_chart_snapshot_hour; Type: MATERIALIZED VIEW; Schema: charting; Owner: rathore
--

CREATE MATERIALIZED VIEW charting.instrument_chart_snapshot_hour AS
 SELECT im.exchange_code,
    im.symbol,
    im.trading_symbol,
    mc.instrument_id,
    (mc.timeframe)::text AS timeframe,
    mc.tf_id,
    mc.bar_start_ts AS date,
    mc.candle_week,
    mc.trade_date AS candle_date,
    (mc.bar_start_ts)::time without time zone AS candle_time,
    mc.open,
    mc.high,
    mc.low,
    mc.close,
    ff.sma_5,
    ff.sma_10,
    ff.sma_20,
    ff.sma_50,
    ff.sma_100,
    ff.sma_200,
    ff.atr_5,
    mc.volume,
    p.pivot_type,
    p.pivot_left_arm_length,
    p.pivot_right_arm_length,
    p.pivot_left_arm_strength,
    p.pivot_right_arm_strength,
    p.trend_pivot_type,
    p.trend_left_arm_length,
    p.trend_right_arm_length,
    p.trend_left_arm_strength,
    p.trend_right_arm_strength,
    ff.range_to_atr,
    ff.body_pct,
    ff.upper_wick_pct,
    ff.lower_wick_pct
   FROM (((market_nse.market_candle mc
     JOIN exchange_symbol.instrument_master im ON ((im.instrument_id = mc.instrument_id)))
     LEFT JOIN market_nse.market_candle_feature_fast ff ON (((ff.instrument_id = mc.instrument_id) AND (ff.timeframe = mc.timeframe) AND (ff.bar_start_ts = mc.bar_start_ts))))
     LEFT JOIN market_nse.market_candle_pivot p ON (((p.instrument_id = mc.instrument_id) AND (p.timeframe = mc.timeframe) AND (p.bar_start_ts = mc.bar_start_ts))))
  WHERE (mc.timeframe = 'hour'::public.timeframe_enum)
UNION ALL
 SELECT im.exchange_code,
    im.symbol,
    im.trading_symbol,
    mc.instrument_id,
    (mc.timeframe)::text AS timeframe,
    mc.tf_id,
    mc.bar_start_ts AS date,
    mc.candle_week,
    mc.trade_date AS candle_date,
    (mc.bar_start_ts)::time without time zone AS candle_time,
    mc.open,
    mc.high,
    mc.low,
    mc.close,
    ff.sma_5,
    ff.sma_10,
    ff.sma_20,
    ff.sma_50,
    ff.sma_100,
    ff.sma_200,
    ff.atr_5,
    mc.volume,
    p.pivot_type,
    p.pivot_left_arm_length,
    p.pivot_right_arm_length,
    p.pivot_left_arm_strength,
    p.pivot_right_arm_strength,
    p.trend_pivot_type,
    p.trend_left_arm_length,
    p.trend_right_arm_length,
    p.trend_left_arm_strength,
    p.trend_right_arm_strength,
    ff.range_to_atr,
    ff.body_pct,
    ff.upper_wick_pct,
    ff.lower_wick_pct
   FROM (((market_nfo.market_candle mc
     JOIN exchange_symbol.instrument_master im ON ((im.instrument_id = mc.instrument_id)))
     LEFT JOIN market_nfo.market_candle_feature_fast ff ON (((ff.instrument_id = mc.instrument_id) AND (ff.timeframe = mc.timeframe) AND (ff.bar_start_ts = mc.bar_start_ts))))
     LEFT JOIN market_nfo.market_candle_pivot p ON (((p.instrument_id = mc.instrument_id) AND (p.timeframe = mc.timeframe) AND (p.bar_start_ts = mc.bar_start_ts))))
  WHERE (mc.timeframe = 'hour'::public.timeframe_enum)
UNION ALL
 SELECT im.exchange_code,
    im.symbol,
    im.trading_symbol,
    mc.instrument_id,
    (mc.timeframe)::text AS timeframe,
    mc.tf_id,
    mc.bar_start_ts AS date,
    mc.candle_week,
    mc.trade_date AS candle_date,
    (mc.bar_start_ts)::time without time zone AS candle_time,
    mc.open,
    mc.high,
    mc.low,
    mc.close,
    ff.sma_5,
    ff.sma_10,
    ff.sma_20,
    ff.sma_50,
    ff.sma_100,
    ff.sma_200,
    ff.atr_5,
    mc.volume,
    p.pivot_type,
    p.pivot_left_arm_length,
    p.pivot_right_arm_length,
    p.pivot_left_arm_strength,
    p.pivot_right_arm_strength,
    p.trend_pivot_type,
    p.trend_left_arm_length,
    p.trend_right_arm_length,
    p.trend_left_arm_strength,
    p.trend_right_arm_strength,
    ff.range_to_atr,
    ff.body_pct,
    ff.upper_wick_pct,
    ff.lower_wick_pct
   FROM (((market_mcx.market_candle mc
     JOIN exchange_symbol.instrument_master im ON ((im.instrument_id = mc.instrument_id)))
     LEFT JOIN market_mcx.market_candle_feature_fast ff ON (((ff.instrument_id = mc.instrument_id) AND (ff.timeframe = mc.timeframe) AND (ff.bar_start_ts = mc.bar_start_ts))))
     LEFT JOIN market_mcx.market_candle_pivot p ON (((p.instrument_id = mc.instrument_id) AND (p.timeframe = mc.timeframe) AND (p.bar_start_ts = mc.bar_start_ts))))
  WHERE (mc.timeframe = 'hour'::public.timeframe_enum)
  WITH NO DATA;


ALTER MATERIALIZED VIEW charting.instrument_chart_snapshot_hour OWNER TO rathore;

--
-- Name: instrument_chart_snapshot_month; Type: MATERIALIZED VIEW; Schema: charting; Owner: rathore
--

CREATE MATERIALIZED VIEW charting.instrument_chart_snapshot_month AS
 SELECT im.exchange_code,
    im.symbol,
    im.trading_symbol,
    mc.instrument_id,
    (mc.timeframe)::text AS timeframe,
    mc.tf_id,
    mc.bar_start_ts AS date,
    mc.candle_week,
    mc.trade_date AS candle_date,
    (mc.bar_start_ts)::time without time zone AS candle_time,
    mc.open,
    mc.high,
    mc.low,
    mc.close,
    ff.sma_5,
    ff.sma_10,
    ff.sma_20,
    ff.sma_50,
    ff.sma_100,
    ff.sma_200,
    ff.atr_5,
    mc.volume,
    p.pivot_type,
    p.pivot_left_arm_length,
    p.pivot_right_arm_length,
    p.pivot_left_arm_strength,
    p.pivot_right_arm_strength,
    p.trend_pivot_type,
    p.trend_left_arm_length,
    p.trend_right_arm_length,
    p.trend_left_arm_strength,
    p.trend_right_arm_strength,
    ff.range_to_atr,
    ff.body_pct,
    ff.upper_wick_pct,
    ff.lower_wick_pct
   FROM (((market_nse.market_candle mc
     JOIN exchange_symbol.instrument_master im ON ((im.instrument_id = mc.instrument_id)))
     LEFT JOIN market_nse.market_candle_feature_fast ff ON (((ff.instrument_id = mc.instrument_id) AND (ff.timeframe = mc.timeframe) AND (ff.bar_start_ts = mc.bar_start_ts))))
     LEFT JOIN market_nse.market_candle_pivot p ON (((p.instrument_id = mc.instrument_id) AND (p.timeframe = mc.timeframe) AND (p.bar_start_ts = mc.bar_start_ts))))
  WHERE (mc.timeframe = 'month'::public.timeframe_enum)
UNION ALL
 SELECT im.exchange_code,
    im.symbol,
    im.trading_symbol,
    mc.instrument_id,
    (mc.timeframe)::text AS timeframe,
    mc.tf_id,
    mc.bar_start_ts AS date,
    mc.candle_week,
    mc.trade_date AS candle_date,
    (mc.bar_start_ts)::time without time zone AS candle_time,
    mc.open,
    mc.high,
    mc.low,
    mc.close,
    ff.sma_5,
    ff.sma_10,
    ff.sma_20,
    ff.sma_50,
    ff.sma_100,
    ff.sma_200,
    ff.atr_5,
    mc.volume,
    p.pivot_type,
    p.pivot_left_arm_length,
    p.pivot_right_arm_length,
    p.pivot_left_arm_strength,
    p.pivot_right_arm_strength,
    p.trend_pivot_type,
    p.trend_left_arm_length,
    p.trend_right_arm_length,
    p.trend_left_arm_strength,
    p.trend_right_arm_strength,
    ff.range_to_atr,
    ff.body_pct,
    ff.upper_wick_pct,
    ff.lower_wick_pct
   FROM (((market_nfo.market_candle mc
     JOIN exchange_symbol.instrument_master im ON ((im.instrument_id = mc.instrument_id)))
     LEFT JOIN market_nfo.market_candle_feature_fast ff ON (((ff.instrument_id = mc.instrument_id) AND (ff.timeframe = mc.timeframe) AND (ff.bar_start_ts = mc.bar_start_ts))))
     LEFT JOIN market_nfo.market_candle_pivot p ON (((p.instrument_id = mc.instrument_id) AND (p.timeframe = mc.timeframe) AND (p.bar_start_ts = mc.bar_start_ts))))
  WHERE (mc.timeframe = 'month'::public.timeframe_enum)
UNION ALL
 SELECT im.exchange_code,
    im.symbol,
    im.trading_symbol,
    mc.instrument_id,
    (mc.timeframe)::text AS timeframe,
    mc.tf_id,
    mc.bar_start_ts AS date,
    mc.candle_week,
    mc.trade_date AS candle_date,
    (mc.bar_start_ts)::time without time zone AS candle_time,
    mc.open,
    mc.high,
    mc.low,
    mc.close,
    ff.sma_5,
    ff.sma_10,
    ff.sma_20,
    ff.sma_50,
    ff.sma_100,
    ff.sma_200,
    ff.atr_5,
    mc.volume,
    p.pivot_type,
    p.pivot_left_arm_length,
    p.pivot_right_arm_length,
    p.pivot_left_arm_strength,
    p.pivot_right_arm_strength,
    p.trend_pivot_type,
    p.trend_left_arm_length,
    p.trend_right_arm_length,
    p.trend_left_arm_strength,
    p.trend_right_arm_strength,
    ff.range_to_atr,
    ff.body_pct,
    ff.upper_wick_pct,
    ff.lower_wick_pct
   FROM (((market_mcx.market_candle mc
     JOIN exchange_symbol.instrument_master im ON ((im.instrument_id = mc.instrument_id)))
     LEFT JOIN market_mcx.market_candle_feature_fast ff ON (((ff.instrument_id = mc.instrument_id) AND (ff.timeframe = mc.timeframe) AND (ff.bar_start_ts = mc.bar_start_ts))))
     LEFT JOIN market_mcx.market_candle_pivot p ON (((p.instrument_id = mc.instrument_id) AND (p.timeframe = mc.timeframe) AND (p.bar_start_ts = mc.bar_start_ts))))
  WHERE (mc.timeframe = 'month'::public.timeframe_enum)
  WITH NO DATA;


ALTER MATERIALIZED VIEW charting.instrument_chart_snapshot_month OWNER TO rathore;

--
-- Name: instrument_chart_snapshot_week; Type: MATERIALIZED VIEW; Schema: charting; Owner: rathore
--

CREATE MATERIALIZED VIEW charting.instrument_chart_snapshot_week AS
 SELECT im.exchange_code,
    im.symbol,
    im.trading_symbol,
    mc.instrument_id,
    (mc.timeframe)::text AS timeframe,
    mc.tf_id,
    mc.bar_start_ts AS date,
    mc.candle_week,
    mc.trade_date AS candle_date,
    (mc.bar_start_ts)::time without time zone AS candle_time,
    mc.open,
    mc.high,
    mc.low,
    mc.close,
    ff.sma_5,
    ff.sma_10,
    ff.sma_20,
    ff.sma_50,
    ff.sma_100,
    ff.sma_200,
    ff.atr_5,
    mc.volume,
    p.pivot_type,
    p.pivot_left_arm_length,
    p.pivot_right_arm_length,
    p.pivot_left_arm_strength,
    p.pivot_right_arm_strength,
    p.trend_pivot_type,
    p.trend_left_arm_length,
    p.trend_right_arm_length,
    p.trend_left_arm_strength,
    p.trend_right_arm_strength,
    ff.range_to_atr,
    ff.body_pct,
    ff.upper_wick_pct,
    ff.lower_wick_pct
   FROM (((market_nse.market_candle mc
     JOIN exchange_symbol.instrument_master im ON ((im.instrument_id = mc.instrument_id)))
     LEFT JOIN market_nse.market_candle_feature_fast ff ON (((ff.instrument_id = mc.instrument_id) AND (ff.timeframe = mc.timeframe) AND (ff.bar_start_ts = mc.bar_start_ts))))
     LEFT JOIN market_nse.market_candle_pivot p ON (((p.instrument_id = mc.instrument_id) AND (p.timeframe = mc.timeframe) AND (p.bar_start_ts = mc.bar_start_ts))))
  WHERE (mc.timeframe = 'week'::public.timeframe_enum)
UNION ALL
 SELECT im.exchange_code,
    im.symbol,
    im.trading_symbol,
    mc.instrument_id,
    (mc.timeframe)::text AS timeframe,
    mc.tf_id,
    mc.bar_start_ts AS date,
    mc.candle_week,
    mc.trade_date AS candle_date,
    (mc.bar_start_ts)::time without time zone AS candle_time,
    mc.open,
    mc.high,
    mc.low,
    mc.close,
    ff.sma_5,
    ff.sma_10,
    ff.sma_20,
    ff.sma_50,
    ff.sma_100,
    ff.sma_200,
    ff.atr_5,
    mc.volume,
    p.pivot_type,
    p.pivot_left_arm_length,
    p.pivot_right_arm_length,
    p.pivot_left_arm_strength,
    p.pivot_right_arm_strength,
    p.trend_pivot_type,
    p.trend_left_arm_length,
    p.trend_right_arm_length,
    p.trend_left_arm_strength,
    p.trend_right_arm_strength,
    ff.range_to_atr,
    ff.body_pct,
    ff.upper_wick_pct,
    ff.lower_wick_pct
   FROM (((market_nfo.market_candle mc
     JOIN exchange_symbol.instrument_master im ON ((im.instrument_id = mc.instrument_id)))
     LEFT JOIN market_nfo.market_candle_feature_fast ff ON (((ff.instrument_id = mc.instrument_id) AND (ff.timeframe = mc.timeframe) AND (ff.bar_start_ts = mc.bar_start_ts))))
     LEFT JOIN market_nfo.market_candle_pivot p ON (((p.instrument_id = mc.instrument_id) AND (p.timeframe = mc.timeframe) AND (p.bar_start_ts = mc.bar_start_ts))))
  WHERE (mc.timeframe = 'week'::public.timeframe_enum)
UNION ALL
 SELECT im.exchange_code,
    im.symbol,
    im.trading_symbol,
    mc.instrument_id,
    (mc.timeframe)::text AS timeframe,
    mc.tf_id,
    mc.bar_start_ts AS date,
    mc.candle_week,
    mc.trade_date AS candle_date,
    (mc.bar_start_ts)::time without time zone AS candle_time,
    mc.open,
    mc.high,
    mc.low,
    mc.close,
    ff.sma_5,
    ff.sma_10,
    ff.sma_20,
    ff.sma_50,
    ff.sma_100,
    ff.sma_200,
    ff.atr_5,
    mc.volume,
    p.pivot_type,
    p.pivot_left_arm_length,
    p.pivot_right_arm_length,
    p.pivot_left_arm_strength,
    p.pivot_right_arm_strength,
    p.trend_pivot_type,
    p.trend_left_arm_length,
    p.trend_right_arm_length,
    p.trend_left_arm_strength,
    p.trend_right_arm_strength,
    ff.range_to_atr,
    ff.body_pct,
    ff.upper_wick_pct,
    ff.lower_wick_pct
   FROM (((market_mcx.market_candle mc
     JOIN exchange_symbol.instrument_master im ON ((im.instrument_id = mc.instrument_id)))
     LEFT JOIN market_mcx.market_candle_feature_fast ff ON (((ff.instrument_id = mc.instrument_id) AND (ff.timeframe = mc.timeframe) AND (ff.bar_start_ts = mc.bar_start_ts))))
     LEFT JOIN market_mcx.market_candle_pivot p ON (((p.instrument_id = mc.instrument_id) AND (p.timeframe = mc.timeframe) AND (p.bar_start_ts = mc.bar_start_ts))))
  WHERE (mc.timeframe = 'week'::public.timeframe_enum)
  WITH NO DATA;


ALTER MATERIALIZED VIEW charting.instrument_chart_snapshot_week OWNER TO rathore;

--
-- Name: candle_matrix_metrics; Type: TABLE; Schema: core_app_mcx; Owner: rathore
--

CREATE TABLE core_app_mcx.candle_matrix_metrics (
    instrument_id bigint NOT NULL,
    exchange_code character varying(10) NOT NULL,
    symbol character varying(50) NOT NULL,
    timeframe character varying(20) NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    bar_end_ts timestamp without time zone,
    trade_date date,
    candle_week date,
    open_price numeric(18,6) NOT NULL,
    high_price numeric(18,6) NOT NULL,
    low_price numeric(18,6) NOT NULL,
    close_price numeric(18,6) NOT NULL,
    atr_5 numeric(18,6),
    sma_5 numeric(18,6),
    sma_10 numeric(18,6),
    sma_20 numeric(18,6),
    sma_50 numeric(18,6),
    range_to_atr numeric(10,4),
    body_pct numeric(10,4),
    upper_wick_pct numeric(10,4),
    lower_wick_pct numeric(10,4),
    range_class character varying(20),
    body_class character varying(20),
    tail_class character varying(30),
    final_category character varying(40),
    candle_direction smallint,
    candle_retrace_pct numeric(10,4),
    candle_retrace_category character varying(20),
    candle_engulfing boolean,
    candle_retrace_2bar_pct numeric(10,4),
    candle_retrace_2bar_category character varying(20),
    candle_retrace_3bar_pct numeric(10,4),
    candle_retrace_3bar_category character varying(20),
    pivot_retrace_pct numeric(10,4),
    pivot_retrace_category character varying(20),
    pivot_trend_direction character varying(10),
    structure_break boolean,
    wick_exhaustion_context character varying(30),
    active_pivot_tf_id bigint,
    active_pivot_type character varying(10),
    opposite_pivot_tf_id bigint,
    opposite_pivot_type character varying(10),
    prior_same_side_pivot_tf_id bigint,
    pivot_pair_span_bars integer,
    pivot_anchor_price_1 numeric(18,6),
    pivot_anchor_price_2 numeric(18,6),
    pivot_to_pivot_retrace_pct numeric(10,4),
    pivot_to_pivot_retrace_category character varying(20),
    pivot_to_pivot_structure_break boolean,
    sma_in_range_count smallint,
    sma20_trend_direction character varying(5),
    sma20_trend_run integer,
    sma5_lis_length integer,
    sma10_lis_length integer,
    close_open_dominance_count integer,
    bar_sequence_tag character varying(30),
    candle_matrix_score numeric(5,1),
    candle_matrix_direction smallint,
    range_progression_ratio numeric(10,4),
    range_progression_tag character varying(20),
    trend_strength_score numeric(5,1),
    retrace_bias character varying(30),
    error_code character varying(40),
    error_detail jsonb,
    source_pivot_table character varying(40),
    source_meta_pivot_table character varying(40),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE core_app_mcx.candle_matrix_metrics OWNER TO rathore;

--
-- Name: candle_nbar_state; Type: TABLE; Schema: core_app_mcx; Owner: rathore
--

CREATE TABLE core_app_mcx.candle_nbar_state (
    instrument_id bigint NOT NULL,
    exchange_code character varying(10) NOT NULL,
    symbol character varying(50) NOT NULL,
    timeframe character varying(20) NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    open_1 numeric(18,6),
    high_1 numeric(18,6),
    low_1 numeric(18,6),
    close_1 numeric(18,6),
    range_class_1 character varying(20),
    body_class_1 character varying(20),
    tail_class_1 character varying(30),
    category_1 character varying(40),
    direction_1 smallint,
    range_to_atr_1 numeric(10,4),
    body_pct_1 numeric(10,4),
    upper_wick_pct_1 numeric(10,4),
    lower_wick_pct_1 numeric(10,4),
    open_2 numeric(18,6),
    high_2 numeric(18,6),
    low_2 numeric(18,6),
    close_2 numeric(18,6),
    range_class_2 character varying(20),
    body_class_2 character varying(20),
    tail_class_2 character varying(30),
    category_2 character varying(40),
    direction_2 smallint,
    range_to_atr_2 numeric(10,4),
    body_pct_2 numeric(10,4),
    upper_wick_pct_2 numeric(10,4),
    lower_wick_pct_2 numeric(10,4),
    open_3 numeric(18,6),
    high_3 numeric(18,6),
    low_3 numeric(18,6),
    close_3 numeric(18,6),
    range_class_3 character varying(20),
    body_class_3 character varying(20),
    tail_class_3 character varying(30),
    category_3 character varying(40),
    direction_3 smallint,
    range_to_atr_3 numeric(10,4),
    body_pct_3 numeric(10,4),
    upper_wick_pct_3 numeric(10,4),
    lower_wick_pct_3 numeric(10,4),
    open_4 numeric(18,6),
    high_4 numeric(18,6),
    low_4 numeric(18,6),
    close_4 numeric(18,6),
    range_class_4 character varying(20),
    body_class_4 character varying(20),
    tail_class_4 character varying(30),
    category_4 character varying(40),
    direction_4 smallint,
    range_to_atr_4 numeric(10,4),
    body_pct_4 numeric(10,4),
    upper_wick_pct_4 numeric(10,4),
    lower_wick_pct_4 numeric(10,4),
    range_progression_ratio numeric(10,4),
    range_progression_tag character varying(20),
    candle_matrix_score numeric(5,1),
    candle_matrix_direction smallint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE core_app_mcx.candle_nbar_state OWNER TO rathore;

--
-- Name: fractal_trend_pivots_metrics; Type: TABLE; Schema: core_app_mcx; Owner: rathore
--

CREATE TABLE core_app_mcx.fractal_trend_pivots_metrics (
    symbol character varying(50) NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    is_pivot_high boolean DEFAULT false,
    is_pivot_low boolean DEFAULT false,
    pivot_high_value numeric(10,2),
    pivot_low_value numeric(10,2),
    is_zigzag_pivot boolean DEFAULT false,
    zigzag_direction integer,
    zigzag_value numeric(10,2),
    "3b_fractal_trnd_pvt" character varying(8),
    "3b_fractal_trnd_pvt_left_arm_length" integer,
    "3b_fractal_trnd_pvt_right_arm_length" integer,
    "3b_fractal_trnd_pvt_left_arm_strength" integer,
    "3b_fractal_trnd_pvt_right_arm_strength" integer,
    pattern_point_a numeric(10,2),
    pattern_point_b numeric(10,2),
    pattern_point_c numeric(10,2),
    pattern_point_d numeric(10,2),
    pattern_point_e numeric(10,2),
    support_level numeric(12,4),
    resistance_level numeric(12,4),
    support_changed boolean DEFAULT false,
    resistance_changed boolean DEFAULT false,
    current_trend integer,
    pivot_calculated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    pattern_type character varying(20)
);


ALTER TABLE core_app_mcx.fractal_trend_pivots_metrics OWNER TO rathore;

--
-- Name: n_bar_pivot_metrics; Type: TABLE; Schema: core_app_mcx; Owner: rathore
--

CREATE TABLE core_app_mcx.n_bar_pivot_metrics (
    symbol character varying(50) NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    "1b_pvt" character varying(5),
    "2b_pvt" character varying(5),
    "3b_pvt" character varying(5),
    "1b_trnd_pvt" character varying(5),
    "2b_trnd_pvt" character varying(5),
    "3b_trnd_pvt" character varying(5),
    "1b_pvt_left_arm_length" integer,
    "1b_pvt_right_arm_length" integer,
    "1b_pvt_left_arm_strength" integer,
    "1b_pvt_right_arm_strength" integer,
    "1b_trnd_pvt_left_arm_length" integer,
    "1b_trnd_pvt_right_arm_length" integer,
    "1b_trnd_pvt_left_arm_strength" integer,
    "1b_trnd_pvt_right_arm_strength" integer,
    "2b_pvt_left_arm_length" integer,
    "2b_pvt_right_arm_length" integer,
    "2b_pvt_left_arm_strength" integer,
    "2b_pvt_right_arm_strength" integer,
    "2b_trnd_pvt_left_arm_length" integer,
    "2b_trnd_pvt_right_arm_length" integer,
    "2b_trnd_pvt_left_arm_strength" integer,
    "2b_trnd_pvt_right_arm_strength" integer,
    "3b_pvt_left_arm_length" integer,
    "3b_pvt_right_arm_length" integer,
    "3b_pvt_left_arm_strength" integer,
    "3b_pvt_right_arm_strength" integer,
    "3b_trnd_pvt_left_arm_length" integer,
    "3b_trnd_pvt_right_arm_length" integer,
    "3b_trnd_pvt_left_arm_strength" integer,
    "3b_trnd_pvt_right_arm_strength" integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "1b_level_side" character varying(16),
    "2b_level_side" character varying(16),
    "3b_level_side" character varying(16),
    CONSTRAINT chk_n_bar_1b_level_side CHECK ((("1b_level_side" IS NULL) OR (("1b_level_side")::text = ANY (ARRAY[('SUPPORT'::character varying)::text, ('RESISTANCE'::character varying)::text])))),
    CONSTRAINT chk_n_bar_2b_level_side CHECK ((("2b_level_side" IS NULL) OR (("2b_level_side")::text = ANY (ARRAY[('SUPPORT'::character varying)::text, ('RESISTANCE'::character varying)::text])))),
    CONSTRAINT chk_n_bar_3b_level_side CHECK ((("3b_level_side" IS NULL) OR (("3b_level_side")::text = ANY (ARRAY[('SUPPORT'::character varying)::text, ('RESISTANCE'::character varying)::text]))))
);


ALTER TABLE core_app_mcx.n_bar_pivot_metrics OWNER TO rathore;

--
-- Name: n_bar_support_resistance_metrics; Type: TABLE; Schema: core_app_mcx; Owner: rathore
--

CREATE TABLE core_app_mcx.n_bar_support_resistance_metrics (
    instrument_id bigint NOT NULL,
    symbol character varying(128) NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    close_price numeric(12,4),
    active_support_1 numeric(12,4),
    active_support_2 numeric(12,4),
    active_support_3 numeric(12,4),
    active_resistance_1 numeric(12,4),
    active_resistance_2 numeric(12,4),
    active_resistance_3 numeric(12,4),
    nearest_support numeric(12,4),
    nearest_resistance numeric(12,4),
    support_source_rank integer,
    resistance_source_rank integer,
    support_changed boolean DEFAULT false,
    resistance_changed boolean DEFAULT false,
    current_trend integer,
    trend_state character varying(24),
    support_distance_pct numeric(12,6),
    resistance_distance_pct numeric(12,6),
    support_score numeric(12,4),
    resistance_score numeric(12,4),
    close_above_resistance boolean,
    close_below_support boolean,
    latest_1b_pvt character varying(8),
    latest_2b_pvt character varying(8),
    latest_3b_pvt character varying(8),
    latest_1b_trnd_pvt character varying(8),
    latest_2b_trnd_pvt character varying(8),
    latest_3b_trnd_pvt character varying(8),
    sr_calculated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE core_app_mcx.n_bar_support_resistance_metrics OWNER TO rathore;

--
-- Name: pipeline_step_tracker; Type: TABLE; Schema: core_app_mcx; Owner: rathore
--

CREATE TABLE core_app_mcx.pipeline_step_tracker (
    tracker_name character varying(100) NOT NULL,
    instrument_id bigint NOT NULL,
    symbol character varying(50) NOT NULL,
    timeframe character varying(20) NOT NULL,
    last_source_tf_id bigint NOT NULL,
    last_opening_pivot_tf_id bigint,
    last_run_status character varying(20) NOT NULL,
    last_run_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE core_app_mcx.pipeline_step_tracker OWNER TO rathore;

--
-- Name: pivot_candle_pivots; Type: TABLE; Schema: core_app_mcx; Owner: rathore
--

CREATE TABLE core_app_mcx.pivot_candle_pivots (
    instrument_id bigint NOT NULL,
    exchange_code character varying(10) NOT NULL,
    symbol character varying(50) NOT NULL,
    timeframe character varying(20) NOT NULL,
    start_at timestamp without time zone NOT NULL,
    end_at timestamp without time zone,
    opening_pivot_candle_id bigint NOT NULL,
    closing_pivot_candle_id bigint,
    candle_type character varying(10),
    pivot_type character varying(10),
    open_price double precision,
    close_price double precision,
    price_length_pct numeric(18,6),
    strength integer,
    candle_count integer,
    left_arm_length integer,
    right_arm_length integer,
    left_arm_strength integer,
    right_arm_strength integer,
    is_temporary boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE core_app_mcx.pivot_candle_pivots OWNER TO rathore;

--
-- Name: pivot_candles; Type: TABLE; Schema: core_app_mcx; Owner: rathore
--

CREATE TABLE core_app_mcx.pivot_candles (
    instrument_id bigint NOT NULL,
    exchange_code character varying(10) NOT NULL,
    symbol character varying(50) NOT NULL,
    timeframe character varying(20) NOT NULL,
    start_at timestamp without time zone NOT NULL,
    end_at timestamp without time zone,
    opening_pivot_tf_id bigint NOT NULL,
    closing_pivot_tf_id bigint,
    candle_type character varying(10),
    open_price double precision,
    close_price double precision,
    price_length_pct numeric(18,6),
    strength integer,
    is_temporary boolean DEFAULT false,
    fractal_pivot_data jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    breadth integer,
    internal_strength integer,
    forward_strength integer,
    left_arm_length integer,
    right_arm_length integer,
    left_arm_strength integer,
    right_arm_strength integer
);


ALTER TABLE core_app_mcx.pivot_candles OWNER TO rathore;

--
-- Name: pivot_metrics; Type: TABLE; Schema: core_app_mcx; Owner: rathore
--

CREATE TABLE core_app_mcx.pivot_metrics (
    id bigint NOT NULL,
    symbol character varying(50) NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint,
    pivot public.pivot_type_enum NOT NULL,
    pivot_price numeric(10,2),
    "timestamp" timestamp without time zone NOT NULL,
    pivot_sequence integer NOT NULL,
    left_arm_length integer,
    right_arm_length integer,
    left_arm_strength integer,
    right_arm_strength integer
);


ALTER TABLE core_app_mcx.pivot_metrics OWNER TO rathore;

--
-- Name: pivot_metrics_id_seq; Type: SEQUENCE; Schema: core_app_mcx; Owner: rathore
--

CREATE SEQUENCE core_app_mcx.pivot_metrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core_app_mcx.pivot_metrics_id_seq OWNER TO rathore;

--
-- Name: pivot_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: core_app_mcx; Owner: rathore
--

ALTER SEQUENCE core_app_mcx.pivot_metrics_id_seq OWNED BY core_app_mcx.pivot_metrics.id;


--
-- Name: trend_pivot_metrics; Type: TABLE; Schema: core_app_mcx; Owner: rathore
--

CREATE TABLE core_app_mcx.trend_pivot_metrics (
    id bigint NOT NULL,
    symbol character varying(50) NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint,
    trend_pivot public.trend_pivot_type_enum NOT NULL,
    pivot_price numeric(10,2),
    "timestamp" timestamp without time zone NOT NULL,
    pivot_sequence integer NOT NULL,
    left_arm_length integer,
    right_arm_length integer,
    left_arm_strength integer,
    right_arm_strength integer
);


ALTER TABLE core_app_mcx.trend_pivot_metrics OWNER TO rathore;

--
-- Name: trend_pivot_metrics_id_seq; Type: SEQUENCE; Schema: core_app_mcx; Owner: rathore
--

CREATE SEQUENCE core_app_mcx.trend_pivot_metrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core_app_mcx.trend_pivot_metrics_id_seq OWNER TO rathore;

--
-- Name: trend_pivot_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: core_app_mcx; Owner: rathore
--

ALTER SEQUENCE core_app_mcx.trend_pivot_metrics_id_seq OWNED BY core_app_mcx.trend_pivot_metrics.id;


--
-- Name: candle_matrix_metrics; Type: TABLE; Schema: core_app_nfo; Owner: rathore
--

CREATE TABLE core_app_nfo.candle_matrix_metrics (
    instrument_id bigint NOT NULL,
    exchange_code character varying(10) NOT NULL,
    symbol character varying(50) NOT NULL,
    timeframe character varying(20) NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    bar_end_ts timestamp without time zone,
    trade_date date,
    candle_week date,
    open_price numeric(18,6) NOT NULL,
    high_price numeric(18,6) NOT NULL,
    low_price numeric(18,6) NOT NULL,
    close_price numeric(18,6) NOT NULL,
    atr_5 numeric(18,6),
    sma_5 numeric(18,6),
    sma_10 numeric(18,6),
    sma_20 numeric(18,6),
    sma_50 numeric(18,6),
    range_to_atr numeric(10,4),
    body_pct numeric(10,4),
    upper_wick_pct numeric(10,4),
    lower_wick_pct numeric(10,4),
    range_class character varying(20),
    body_class character varying(20),
    tail_class character varying(30),
    final_category character varying(40),
    candle_direction smallint,
    candle_retrace_pct numeric(10,4),
    candle_retrace_category character varying(20),
    candle_engulfing boolean,
    candle_retrace_2bar_pct numeric(10,4),
    candle_retrace_2bar_category character varying(20),
    candle_retrace_3bar_pct numeric(10,4),
    candle_retrace_3bar_category character varying(20),
    pivot_retrace_pct numeric(10,4),
    pivot_retrace_category character varying(20),
    pivot_trend_direction character varying(10),
    structure_break boolean,
    wick_exhaustion_context character varying(30),
    active_pivot_tf_id bigint,
    active_pivot_type character varying(10),
    opposite_pivot_tf_id bigint,
    opposite_pivot_type character varying(10),
    prior_same_side_pivot_tf_id bigint,
    pivot_pair_span_bars integer,
    pivot_anchor_price_1 numeric(18,6),
    pivot_anchor_price_2 numeric(18,6),
    pivot_to_pivot_retrace_pct numeric(10,4),
    pivot_to_pivot_retrace_category character varying(20),
    pivot_to_pivot_structure_break boolean,
    sma_in_range_count smallint,
    sma20_trend_direction character varying(5),
    sma20_trend_run integer,
    sma5_lis_length integer,
    sma10_lis_length integer,
    close_open_dominance_count integer,
    bar_sequence_tag character varying(30),
    candle_matrix_score numeric(5,1),
    candle_matrix_direction smallint,
    range_progression_ratio numeric(10,4),
    range_progression_tag character varying(20),
    trend_strength_score numeric(5,1),
    retrace_bias character varying(30),
    error_code character varying(40),
    error_detail jsonb,
    source_pivot_table character varying(40),
    source_meta_pivot_table character varying(40),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE core_app_nfo.candle_matrix_metrics OWNER TO rathore;

--
-- Name: candle_nbar_state; Type: TABLE; Schema: core_app_nfo; Owner: rathore
--

CREATE TABLE core_app_nfo.candle_nbar_state (
    instrument_id bigint NOT NULL,
    exchange_code character varying(10) NOT NULL,
    symbol character varying(50) NOT NULL,
    timeframe character varying(20) NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    open_1 numeric(18,6),
    high_1 numeric(18,6),
    low_1 numeric(18,6),
    close_1 numeric(18,6),
    range_class_1 character varying(20),
    body_class_1 character varying(20),
    tail_class_1 character varying(30),
    category_1 character varying(40),
    direction_1 smallint,
    range_to_atr_1 numeric(10,4),
    body_pct_1 numeric(10,4),
    upper_wick_pct_1 numeric(10,4),
    lower_wick_pct_1 numeric(10,4),
    open_2 numeric(18,6),
    high_2 numeric(18,6),
    low_2 numeric(18,6),
    close_2 numeric(18,6),
    range_class_2 character varying(20),
    body_class_2 character varying(20),
    tail_class_2 character varying(30),
    category_2 character varying(40),
    direction_2 smallint,
    range_to_atr_2 numeric(10,4),
    body_pct_2 numeric(10,4),
    upper_wick_pct_2 numeric(10,4),
    lower_wick_pct_2 numeric(10,4),
    open_3 numeric(18,6),
    high_3 numeric(18,6),
    low_3 numeric(18,6),
    close_3 numeric(18,6),
    range_class_3 character varying(20),
    body_class_3 character varying(20),
    tail_class_3 character varying(30),
    category_3 character varying(40),
    direction_3 smallint,
    range_to_atr_3 numeric(10,4),
    body_pct_3 numeric(10,4),
    upper_wick_pct_3 numeric(10,4),
    lower_wick_pct_3 numeric(10,4),
    open_4 numeric(18,6),
    high_4 numeric(18,6),
    low_4 numeric(18,6),
    close_4 numeric(18,6),
    range_class_4 character varying(20),
    body_class_4 character varying(20),
    tail_class_4 character varying(30),
    category_4 character varying(40),
    direction_4 smallint,
    range_to_atr_4 numeric(10,4),
    body_pct_4 numeric(10,4),
    upper_wick_pct_4 numeric(10,4),
    lower_wick_pct_4 numeric(10,4),
    range_progression_ratio numeric(10,4),
    range_progression_tag character varying(20),
    candle_matrix_score numeric(5,1),
    candle_matrix_direction smallint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE core_app_nfo.candle_nbar_state OWNER TO rathore;

--
-- Name: fractal_trend_pivots_metrics; Type: TABLE; Schema: core_app_nfo; Owner: rathore
--

CREATE TABLE core_app_nfo.fractal_trend_pivots_metrics (
    symbol character varying(50) NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    is_pivot_high boolean DEFAULT false,
    is_pivot_low boolean DEFAULT false,
    pivot_high_value numeric(10,2),
    pivot_low_value numeric(10,2),
    is_zigzag_pivot boolean DEFAULT false,
    zigzag_direction integer,
    zigzag_value numeric(10,2),
    "3b_fractal_trnd_pvt" character varying(8),
    "3b_fractal_trnd_pvt_left_arm_length" integer,
    "3b_fractal_trnd_pvt_right_arm_length" integer,
    "3b_fractal_trnd_pvt_left_arm_strength" integer,
    "3b_fractal_trnd_pvt_right_arm_strength" integer,
    pattern_point_a numeric(10,2),
    pattern_point_b numeric(10,2),
    pattern_point_c numeric(10,2),
    pattern_point_d numeric(10,2),
    pattern_point_e numeric(10,2),
    support_level numeric(12,4),
    resistance_level numeric(12,4),
    support_changed boolean DEFAULT false,
    resistance_changed boolean DEFAULT false,
    current_trend integer,
    pivot_calculated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    pattern_type character varying(20)
);


ALTER TABLE core_app_nfo.fractal_trend_pivots_metrics OWNER TO rathore;

--
-- Name: n_bar_pivot_metrics; Type: TABLE; Schema: core_app_nfo; Owner: rathore
--

CREATE TABLE core_app_nfo.n_bar_pivot_metrics (
    symbol character varying(50) NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    "1b_pvt" character varying(5),
    "2b_pvt" character varying(5),
    "3b_pvt" character varying(5),
    "1b_trnd_pvt" character varying(5),
    "2b_trnd_pvt" character varying(5),
    "3b_trnd_pvt" character varying(5),
    "1b_pvt_left_arm_length" integer,
    "1b_pvt_right_arm_length" integer,
    "1b_pvt_left_arm_strength" integer,
    "1b_pvt_right_arm_strength" integer,
    "1b_trnd_pvt_left_arm_length" integer,
    "1b_trnd_pvt_right_arm_length" integer,
    "1b_trnd_pvt_left_arm_strength" integer,
    "1b_trnd_pvt_right_arm_strength" integer,
    "2b_pvt_left_arm_length" integer,
    "2b_pvt_right_arm_length" integer,
    "2b_pvt_left_arm_strength" integer,
    "2b_pvt_right_arm_strength" integer,
    "2b_trnd_pvt_left_arm_length" integer,
    "2b_trnd_pvt_right_arm_length" integer,
    "2b_trnd_pvt_left_arm_strength" integer,
    "2b_trnd_pvt_right_arm_strength" integer,
    "3b_pvt_left_arm_length" integer,
    "3b_pvt_right_arm_length" integer,
    "3b_pvt_left_arm_strength" integer,
    "3b_pvt_right_arm_strength" integer,
    "3b_trnd_pvt_left_arm_length" integer,
    "3b_trnd_pvt_right_arm_length" integer,
    "3b_trnd_pvt_left_arm_strength" integer,
    "3b_trnd_pvt_right_arm_strength" integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "1b_level_side" character varying(16),
    "2b_level_side" character varying(16),
    "3b_level_side" character varying(16),
    CONSTRAINT chk_n_bar_1b_level_side CHECK ((("1b_level_side" IS NULL) OR (("1b_level_side")::text = ANY (ARRAY[('SUPPORT'::character varying)::text, ('RESISTANCE'::character varying)::text])))),
    CONSTRAINT chk_n_bar_2b_level_side CHECK ((("2b_level_side" IS NULL) OR (("2b_level_side")::text = ANY (ARRAY[('SUPPORT'::character varying)::text, ('RESISTANCE'::character varying)::text])))),
    CONSTRAINT chk_n_bar_3b_level_side CHECK ((("3b_level_side" IS NULL) OR (("3b_level_side")::text = ANY (ARRAY[('SUPPORT'::character varying)::text, ('RESISTANCE'::character varying)::text]))))
);


ALTER TABLE core_app_nfo.n_bar_pivot_metrics OWNER TO rathore;

--
-- Name: n_bar_support_resistance_metrics; Type: TABLE; Schema: core_app_nfo; Owner: rathore
--

CREATE TABLE core_app_nfo.n_bar_support_resistance_metrics (
    instrument_id bigint NOT NULL,
    symbol character varying(128) NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    close_price numeric(12,4),
    active_support_1 numeric(12,4),
    active_support_2 numeric(12,4),
    active_support_3 numeric(12,4),
    active_resistance_1 numeric(12,4),
    active_resistance_2 numeric(12,4),
    active_resistance_3 numeric(12,4),
    nearest_support numeric(12,4),
    nearest_resistance numeric(12,4),
    support_source_rank integer,
    resistance_source_rank integer,
    support_changed boolean DEFAULT false,
    resistance_changed boolean DEFAULT false,
    current_trend integer,
    trend_state character varying(24),
    support_distance_pct numeric(12,6),
    resistance_distance_pct numeric(12,6),
    support_score numeric(12,4),
    resistance_score numeric(12,4),
    close_above_resistance boolean,
    close_below_support boolean,
    latest_1b_pvt character varying(8),
    latest_2b_pvt character varying(8),
    latest_3b_pvt character varying(8),
    latest_1b_trnd_pvt character varying(8),
    latest_2b_trnd_pvt character varying(8),
    latest_3b_trnd_pvt character varying(8),
    sr_calculated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE core_app_nfo.n_bar_support_resistance_metrics OWNER TO rathore;

--
-- Name: pipeline_step_tracker; Type: TABLE; Schema: core_app_nfo; Owner: rathore
--

CREATE TABLE core_app_nfo.pipeline_step_tracker (
    tracker_name character varying(100) NOT NULL,
    instrument_id bigint NOT NULL,
    symbol character varying(50) NOT NULL,
    timeframe character varying(20) NOT NULL,
    last_source_tf_id bigint NOT NULL,
    last_opening_pivot_tf_id bigint,
    last_run_status character varying(20) NOT NULL,
    last_run_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE core_app_nfo.pipeline_step_tracker OWNER TO rathore;

--
-- Name: pivot_candle_pivots; Type: TABLE; Schema: core_app_nfo; Owner: rathore
--

CREATE TABLE core_app_nfo.pivot_candle_pivots (
    instrument_id bigint NOT NULL,
    exchange_code character varying(10) NOT NULL,
    symbol character varying(50) NOT NULL,
    timeframe character varying(20) NOT NULL,
    start_at timestamp without time zone NOT NULL,
    end_at timestamp without time zone,
    opening_pivot_candle_id bigint NOT NULL,
    closing_pivot_candle_id bigint,
    candle_type character varying(10),
    pivot_type character varying(10),
    open_price double precision,
    close_price double precision,
    price_length_pct numeric(18,6),
    strength integer,
    candle_count integer,
    left_arm_length integer,
    right_arm_length integer,
    left_arm_strength integer,
    right_arm_strength integer,
    is_temporary boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE core_app_nfo.pivot_candle_pivots OWNER TO rathore;

--
-- Name: pivot_candles; Type: TABLE; Schema: core_app_nfo; Owner: rathore
--

CREATE TABLE core_app_nfo.pivot_candles (
    instrument_id bigint NOT NULL,
    exchange_code character varying(10) NOT NULL,
    symbol character varying(50) NOT NULL,
    timeframe character varying(20) NOT NULL,
    start_at timestamp without time zone NOT NULL,
    end_at timestamp without time zone,
    opening_pivot_tf_id bigint NOT NULL,
    closing_pivot_tf_id bigint,
    candle_type character varying(10),
    open_price double precision,
    close_price double precision,
    price_length_pct numeric(18,6),
    strength integer,
    is_temporary boolean DEFAULT false,
    fractal_pivot_data jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    breadth integer,
    internal_strength integer,
    forward_strength integer,
    left_arm_length integer,
    right_arm_length integer,
    left_arm_strength integer,
    right_arm_strength integer
);


ALTER TABLE core_app_nfo.pivot_candles OWNER TO rathore;

--
-- Name: pivot_metrics; Type: TABLE; Schema: core_app_nfo; Owner: rathore
--

CREATE TABLE core_app_nfo.pivot_metrics (
    id bigint NOT NULL,
    symbol character varying(50) NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint,
    pivot public.pivot_type_enum NOT NULL,
    pivot_price numeric(10,2),
    "timestamp" timestamp without time zone NOT NULL,
    pivot_sequence integer NOT NULL,
    left_arm_length integer,
    right_arm_length integer,
    left_arm_strength integer,
    right_arm_strength integer
);


ALTER TABLE core_app_nfo.pivot_metrics OWNER TO rathore;

--
-- Name: pivot_metrics_id_seq; Type: SEQUENCE; Schema: core_app_nfo; Owner: rathore
--

CREATE SEQUENCE core_app_nfo.pivot_metrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core_app_nfo.pivot_metrics_id_seq OWNER TO rathore;

--
-- Name: pivot_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: core_app_nfo; Owner: rathore
--

ALTER SEQUENCE core_app_nfo.pivot_metrics_id_seq OWNED BY core_app_nfo.pivot_metrics.id;


--
-- Name: trend_pivot_metrics; Type: TABLE; Schema: core_app_nfo; Owner: rathore
--

CREATE TABLE core_app_nfo.trend_pivot_metrics (
    id bigint NOT NULL,
    symbol character varying(50) NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint,
    trend_pivot public.trend_pivot_type_enum NOT NULL,
    pivot_price numeric(10,2),
    "timestamp" timestamp without time zone NOT NULL,
    pivot_sequence integer NOT NULL,
    left_arm_length integer,
    right_arm_length integer,
    left_arm_strength integer,
    right_arm_strength integer
);


ALTER TABLE core_app_nfo.trend_pivot_metrics OWNER TO rathore;

--
-- Name: trend_pivot_metrics_id_seq; Type: SEQUENCE; Schema: core_app_nfo; Owner: rathore
--

CREATE SEQUENCE core_app_nfo.trend_pivot_metrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core_app_nfo.trend_pivot_metrics_id_seq OWNER TO rathore;

--
-- Name: trend_pivot_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: core_app_nfo; Owner: rathore
--

ALTER SEQUENCE core_app_nfo.trend_pivot_metrics_id_seq OWNED BY core_app_nfo.trend_pivot_metrics.id;


--
-- Name: candle_matrix_metrics; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.candle_matrix_metrics (
    instrument_id bigint NOT NULL,
    exchange_code character varying(10) NOT NULL,
    symbol character varying(128) NOT NULL,
    timeframe character varying(20) NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    bar_end_ts timestamp without time zone,
    trade_date date,
    candle_week date,
    open_price numeric(18,6) NOT NULL,
    high_price numeric(18,6) NOT NULL,
    low_price numeric(18,6) NOT NULL,
    close_price numeric(18,6) NOT NULL,
    atr_5 numeric(18,6),
    sma_5 numeric(18,6),
    sma_10 numeric(18,6),
    sma_20 numeric(18,6),
    sma_50 numeric(18,6),
    range_to_atr numeric(10,4),
    body_pct numeric(10,4),
    upper_wick_pct numeric(10,4),
    lower_wick_pct numeric(10,4),
    range_class character varying(20),
    body_class character varying(20),
    tail_class character varying(30),
    final_category character varying(40),
    candle_direction smallint,
    candle_retrace_pct numeric(10,4),
    candle_retrace_category character varying(20),
    candle_engulfing boolean,
    candle_retrace_2bar_pct numeric(10,4),
    candle_retrace_2bar_category character varying(20),
    candle_retrace_3bar_pct numeric(10,4),
    candle_retrace_3bar_category character varying(20),
    pivot_retrace_pct numeric(10,4),
    pivot_retrace_category character varying(20),
    pivot_trend_direction character varying(10),
    structure_break boolean,
    wick_exhaustion_context character varying(30),
    active_pivot_tf_id bigint,
    active_pivot_type character varying(10),
    opposite_pivot_tf_id bigint,
    opposite_pivot_type character varying(10),
    prior_same_side_pivot_tf_id bigint,
    pivot_pair_span_bars integer,
    pivot_anchor_price_1 numeric(18,6),
    pivot_anchor_price_2 numeric(18,6),
    pivot_to_pivot_retrace_pct numeric(10,4),
    pivot_to_pivot_retrace_category character varying(20),
    pivot_to_pivot_structure_break boolean,
    sma_in_range_count smallint,
    sma20_trend_direction character varying(5),
    sma20_trend_run integer,
    sma5_lis_length integer,
    sma10_lis_length integer,
    close_open_dominance_count integer,
    bar_sequence_tag character varying(30),
    candle_matrix_score numeric(5,1),
    candle_matrix_direction smallint,
    range_progression_ratio numeric(10,4),
    range_progression_tag character varying(20),
    trend_strength_score numeric(5,1),
    retrace_bias character varying(30),
    error_code character varying(40),
    error_detail jsonb,
    source_pivot_table character varying(40),
    source_meta_pivot_table character varying(40),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE core_app_nse.candle_matrix_metrics OWNER TO rathore;

--
-- Name: candle_nbar_state; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.candle_nbar_state (
    instrument_id bigint NOT NULL,
    exchange_code character varying(10) NOT NULL,
    symbol character varying(128) NOT NULL,
    timeframe character varying(20) NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    open_1 numeric(18,6),
    high_1 numeric(18,6),
    low_1 numeric(18,6),
    close_1 numeric(18,6),
    range_class_1 character varying(20),
    body_class_1 character varying(20),
    tail_class_1 character varying(30),
    category_1 character varying(40),
    direction_1 smallint,
    range_to_atr_1 numeric(10,4),
    body_pct_1 numeric(10,4),
    upper_wick_pct_1 numeric(10,4),
    lower_wick_pct_1 numeric(10,4),
    open_2 numeric(18,6),
    high_2 numeric(18,6),
    low_2 numeric(18,6),
    close_2 numeric(18,6),
    range_class_2 character varying(20),
    body_class_2 character varying(20),
    tail_class_2 character varying(30),
    category_2 character varying(40),
    direction_2 smallint,
    range_to_atr_2 numeric(10,4),
    body_pct_2 numeric(10,4),
    upper_wick_pct_2 numeric(10,4),
    lower_wick_pct_2 numeric(10,4),
    open_3 numeric(18,6),
    high_3 numeric(18,6),
    low_3 numeric(18,6),
    close_3 numeric(18,6),
    range_class_3 character varying(20),
    body_class_3 character varying(20),
    tail_class_3 character varying(30),
    category_3 character varying(40),
    direction_3 smallint,
    range_to_atr_3 numeric(10,4),
    body_pct_3 numeric(10,4),
    upper_wick_pct_3 numeric(10,4),
    lower_wick_pct_3 numeric(10,4),
    open_4 numeric(18,6),
    high_4 numeric(18,6),
    low_4 numeric(18,6),
    close_4 numeric(18,6),
    range_class_4 character varying(20),
    body_class_4 character varying(20),
    tail_class_4 character varying(30),
    category_4 character varying(40),
    direction_4 smallint,
    range_to_atr_4 numeric(10,4),
    body_pct_4 numeric(10,4),
    upper_wick_pct_4 numeric(10,4),
    lower_wick_pct_4 numeric(10,4),
    range_progression_ratio numeric(10,4),
    range_progression_tag character varying(20),
    candle_matrix_score numeric(5,1),
    candle_matrix_direction smallint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE core_app_nse.candle_nbar_state OWNER TO rathore;

--
-- Name: fractal_trend_pivots_metrics; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.fractal_trend_pivots_metrics (
    symbol character varying(128) NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    is_pivot_high boolean DEFAULT false,
    is_pivot_low boolean DEFAULT false,
    pivot_high_value numeric(10,2),
    pivot_low_value numeric(10,2),
    is_zigzag_pivot boolean DEFAULT false,
    zigzag_direction integer,
    zigzag_value numeric(10,2),
    "3b_fractal_trnd_pvt" character varying(8),
    "3b_fractal_trnd_pvt_left_arm_length" integer,
    "3b_fractal_trnd_pvt_right_arm_length" integer,
    "3b_fractal_trnd_pvt_left_arm_strength" integer,
    "3b_fractal_trnd_pvt_right_arm_strength" integer,
    pattern_point_a numeric(10,2),
    pattern_point_b numeric(10,2),
    pattern_point_c numeric(10,2),
    pattern_point_d numeric(10,2),
    pattern_point_e numeric(10,2),
    support_level numeric(12,4),
    resistance_level numeric(12,4),
    support_changed boolean DEFAULT false,
    resistance_changed boolean DEFAULT false,
    current_trend integer,
    pivot_calculated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    pattern_type character varying(20)
);


ALTER TABLE core_app_nse.fractal_trend_pivots_metrics OWNER TO rathore;

--
-- Name: n_bar_pivot_metrics; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.n_bar_pivot_metrics (
    symbol character varying(128) NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    "1b_pvt" character varying(5),
    "2b_pvt" character varying(5),
    "3b_pvt" character varying(5),
    "1b_trnd_pvt" character varying(5),
    "2b_trnd_pvt" character varying(5),
    "3b_trnd_pvt" character varying(5),
    "1b_pvt_left_arm_length" integer,
    "1b_pvt_right_arm_length" integer,
    "1b_pvt_left_arm_strength" integer,
    "1b_pvt_right_arm_strength" integer,
    "1b_trnd_pvt_left_arm_length" integer,
    "1b_trnd_pvt_right_arm_length" integer,
    "1b_trnd_pvt_left_arm_strength" integer,
    "1b_trnd_pvt_right_arm_strength" integer,
    "2b_pvt_left_arm_length" integer,
    "2b_pvt_right_arm_length" integer,
    "2b_pvt_left_arm_strength" integer,
    "2b_pvt_right_arm_strength" integer,
    "2b_trnd_pvt_left_arm_length" integer,
    "2b_trnd_pvt_right_arm_length" integer,
    "2b_trnd_pvt_left_arm_strength" integer,
    "2b_trnd_pvt_right_arm_strength" integer,
    "3b_pvt_left_arm_length" integer,
    "3b_pvt_right_arm_length" integer,
    "3b_pvt_left_arm_strength" integer,
    "3b_pvt_right_arm_strength" integer,
    "3b_trnd_pvt_left_arm_length" integer,
    "3b_trnd_pvt_right_arm_length" integer,
    "3b_trnd_pvt_left_arm_strength" integer,
    "3b_trnd_pvt_right_arm_strength" integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "1b_level_side" character varying(16),
    "2b_level_side" character varying(16),
    "3b_level_side" character varying(16),
    CONSTRAINT chk_n_bar_1b_level_side CHECK ((("1b_level_side" IS NULL) OR (("1b_level_side")::text = ANY (ARRAY[('SUPPORT'::character varying)::text, ('RESISTANCE'::character varying)::text])))),
    CONSTRAINT chk_n_bar_2b_level_side CHECK ((("2b_level_side" IS NULL) OR (("2b_level_side")::text = ANY (ARRAY[('SUPPORT'::character varying)::text, ('RESISTANCE'::character varying)::text])))),
    CONSTRAINT chk_n_bar_3b_level_side CHECK ((("3b_level_side" IS NULL) OR (("3b_level_side")::text = ANY (ARRAY[('SUPPORT'::character varying)::text, ('RESISTANCE'::character varying)::text]))))
);


ALTER TABLE core_app_nse.n_bar_pivot_metrics OWNER TO rathore;

--
-- Name: n_bar_support_resistance_metrics; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.n_bar_support_resistance_metrics (
    instrument_id bigint NOT NULL,
    symbol character varying(128) NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    active_support_1 numeric(12,4),
    active_support_2 numeric(12,4),
    active_support_3 numeric(12,4),
    active_resistance_1 numeric(12,4),
    active_resistance_2 numeric(12,4),
    active_resistance_3 numeric(12,4),
    nearest_support numeric(12,4),
    nearest_resistance numeric(12,4),
    support_source_rank integer,
    resistance_source_rank integer,
    support_changed boolean DEFAULT false,
    resistance_changed boolean DEFAULT false,
    current_trend integer,
    trend_state character varying(16),
    support_distance_pct numeric(12,6),
    resistance_distance_pct numeric(12,6),
    close_above_resistance boolean,
    close_below_support boolean,
    sr_calculated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    close_price numeric(12,4)
);


ALTER TABLE core_app_nse.n_bar_support_resistance_metrics OWNER TO rathore;

--
-- Name: phase_c_nbar_mtf_context; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.phase_c_nbar_mtf_context (
    instrument_id bigint NOT NULL,
    symbol character varying(128) NOT NULL,
    exchange_code text NOT NULL,
    as_of_date date NOT NULL,
    hour_bias_score numeric(12,4),
    day_bias_score numeric(12,4),
    week_bias_score numeric(12,4),
    month_bias_score numeric(12,4),
    hour_day_alignment_score numeric(12,4),
    day_week_alignment_score numeric(12,4),
    week_month_alignment_score numeric(12,4),
    mtf_alignment_score numeric(12,4),
    dominant_structure character varying(24),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE core_app_nse.phase_c_nbar_mtf_context OWNER TO rathore;

--
-- Name: phase_c_nbar_structural_context; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.phase_c_nbar_structural_context (
    instrument_id bigint NOT NULL,
    symbol character varying(128) NOT NULL,
    exchange_code text NOT NULL,
    as_of_date date NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    nbar_trend_state character varying(24),
    nbar_current_trend integer,
    nbar_nearest_support numeric(12,4),
    nbar_nearest_resistance numeric(12,4),
    nbar_support_distance_pct numeric(12,6),
    nbar_resistance_distance_pct numeric(12,6),
    nbar_support_score numeric(12,4),
    nbar_resistance_score numeric(12,4),
    nbar_support_source_rank integer,
    nbar_resistance_source_rank integer,
    nbar_support_changed boolean,
    nbar_resistance_changed boolean,
    nbar_close_above_resistance boolean,
    nbar_close_below_support boolean,
    structural_bias_score numeric(12,4),
    structural_pressure_score numeric(12,4),
    support_quality_score numeric(12,4),
    resistance_quality_score numeric(12,4),
    breakout_readiness_score numeric(12,4),
    breakdown_readiness_score numeric(12,4),
    support_retest_quality_score numeric(12,4),
    resistance_retest_quality_score numeric(12,4),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE core_app_nse.phase_c_nbar_structural_context OWNER TO rathore;

--
-- Name: phase_d_structural_signal_scores; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.phase_d_structural_signal_scores (
    instrument_id bigint NOT NULL,
    symbol character varying(128) NOT NULL,
    exchange_code text NOT NULL,
    as_of_date date NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    signal_type character varying(32),
    signal_side character varying(8),
    structural_trigger_score numeric(12,4),
    near_opposing_level_penalty numeric(12,4),
    structure_instability_penalty numeric(12,4),
    regime_fit_score numeric(12,4),
    risk_adjusted_opportunity_score numeric(12,4),
    mtf_alignment_score numeric(12,4),
    breakout_readiness_score numeric(12,4),
    breakdown_readiness_score numeric(12,4),
    support_retest_quality_score numeric(12,4),
    resistance_retest_quality_score numeric(12,4),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE core_app_nse.phase_d_structural_signal_scores OWNER TO rathore;

--
-- Name: phase_d_watchlist_structural_rankings; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.phase_d_watchlist_structural_rankings (
    instrument_id bigint NOT NULL,
    symbol character varying(128) NOT NULL,
    exchange_code text NOT NULL,
    as_of_date date NOT NULL,
    dominant_signal_type character varying(32),
    dominant_signal_side character varying(8),
    watchlist_candidate_score numeric(12,4),
    triggerable_alert_score numeric(12,4),
    risk_adjusted_opportunity_score numeric(12,4),
    mtf_alignment_score numeric(12,4),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE core_app_nse.phase_d_watchlist_structural_rankings OWNER TO rathore;

--
-- Name: pipeline_step_tracker; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.pipeline_step_tracker (
    tracker_name character varying(100) NOT NULL,
    instrument_id bigint NOT NULL,
    symbol character varying(128) NOT NULL,
    timeframe character varying(20) NOT NULL,
    last_source_tf_id bigint NOT NULL,
    last_opening_pivot_tf_id bigint,
    last_run_status character varying(20) NOT NULL,
    last_run_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE core_app_nse.pipeline_step_tracker OWNER TO rathore;

--
-- Name: pivot_candle_pivots; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.pivot_candle_pivots (
    instrument_id bigint NOT NULL,
    exchange_code character varying(10) NOT NULL,
    symbol character varying(128) NOT NULL,
    timeframe character varying(20) NOT NULL,
    start_at timestamp without time zone NOT NULL,
    end_at timestamp without time zone,
    opening_pivot_candle_id bigint NOT NULL,
    closing_pivot_candle_id bigint,
    candle_type character varying(10),
    pivot_type character varying(10),
    open_price double precision,
    close_price double precision,
    price_length_pct numeric(18,6),
    strength integer,
    candle_count integer,
    left_arm_length integer,
    right_arm_length integer,
    left_arm_strength integer,
    right_arm_strength integer,
    is_temporary boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE core_app_nse.pivot_candle_pivots OWNER TO rathore;

--
-- Name: pivot_candles; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.pivot_candles (
    instrument_id bigint NOT NULL,
    exchange_code character varying(10) NOT NULL,
    symbol character varying(128) NOT NULL,
    timeframe character varying(20) NOT NULL,
    start_at timestamp without time zone NOT NULL,
    end_at timestamp without time zone,
    opening_pivot_tf_id bigint NOT NULL,
    closing_pivot_tf_id bigint,
    candle_type character varying(10),
    open_price double precision,
    close_price double precision,
    price_length_pct numeric(18,6),
    strength integer,
    is_temporary boolean DEFAULT false,
    fractal_pivot_data jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    breadth integer,
    internal_strength integer,
    forward_strength integer,
    left_arm_length integer,
    right_arm_length integer,
    left_arm_strength integer,
    right_arm_strength integer
);


ALTER TABLE core_app_nse.pivot_candles OWNER TO rathore;

--
-- Name: pivot_metrics; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.pivot_metrics (
    id bigint NOT NULL,
    symbol character varying(128) NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint,
    pivot public.pivot_type_enum NOT NULL,
    pivot_price numeric(10,2),
    "timestamp" timestamp without time zone NOT NULL,
    pivot_sequence integer NOT NULL,
    left_arm_length integer,
    right_arm_length integer,
    left_arm_strength integer,
    right_arm_strength integer
);


ALTER TABLE core_app_nse.pivot_metrics OWNER TO rathore;

--
-- Name: pivot_metrics_id_seq; Type: SEQUENCE; Schema: core_app_nse; Owner: rathore
--

CREATE SEQUENCE core_app_nse.pivot_metrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core_app_nse.pivot_metrics_id_seq OWNER TO rathore;

--
-- Name: pivot_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: core_app_nse; Owner: rathore
--

ALTER SEQUENCE core_app_nse.pivot_metrics_id_seq OWNED BY core_app_nse.pivot_metrics.id;


--
-- Name: trend_pivot_metrics; Type: TABLE; Schema: core_app_nse; Owner: rathore
--

CREATE TABLE core_app_nse.trend_pivot_metrics (
    id bigint NOT NULL,
    symbol character varying(128) NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint,
    trend_pivot public.trend_pivot_type_enum NOT NULL,
    pivot_price numeric(10,2),
    "timestamp" timestamp without time zone NOT NULL,
    pivot_sequence integer NOT NULL,
    left_arm_length integer,
    right_arm_length integer,
    left_arm_strength integer,
    right_arm_strength integer
);


ALTER TABLE core_app_nse.trend_pivot_metrics OWNER TO rathore;

--
-- Name: trend_pivot_metrics_id_seq; Type: SEQUENCE; Schema: core_app_nse; Owner: rathore
--

CREATE SEQUENCE core_app_nse.trend_pivot_metrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core_app_nse.trend_pivot_metrics_id_seq OWNER TO rathore;

--
-- Name: trend_pivot_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: core_app_nse; Owner: rathore
--

ALTER SEQUENCE core_app_nse.trend_pivot_metrics_id_seq OWNED BY core_app_nse.trend_pivot_metrics.id;


--
-- Name: nse_market_activity_market_report; Type: TABLE; Schema: exchange; Owner: rathore
--

CREATE TABLE exchange.nse_market_activity_market_report (
    trade_date date NOT NULL,
    source_file text,
    summary_json jsonb,
    gain_loss_json jsonb,
    indices_json jsonb,
    footer_json jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE exchange.nse_market_activity_market_report OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE; Schema: exchange_symbol; Owner: rathore
--

CREATE SEQUENCE exchange_symbol.instrument_master_instrument_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE exchange_symbol.instrument_master_instrument_id_seq OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: exchange_symbol; Owner: rathore
--

ALTER SEQUENCE exchange_symbol.instrument_master_instrument_id_seq OWNED BY exchange_symbol.instrument_master.instrument_id;


--
-- Name: account_capital_state; Type: TABLE; Schema: market_intelligence; Owner: rathore
--

CREATE TABLE market_intelligence.account_capital_state (
    trade_date date NOT NULL,
    total_capital double precision,
    available_capital double precision,
    risk_budget_pct double precision,
    max_trades integer,
    max_per_sector integer,
    planned_trade_count integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE market_intelligence.account_capital_state OWNER TO rathore;

--
-- Name: market_breadth_snapshot; Type: TABLE; Schema: market_intelligence; Owner: rathore
--

CREATE TABLE market_intelligence.market_breadth_snapshot (
    trade_date date NOT NULL,
    breadth_scope text NOT NULL,
    advance_count integer,
    decline_count integer,
    unchanged_count integer,
    bullish_signal_count integer,
    bearish_signal_count integer,
    watch_count integer,
    avoid_count integer,
    avg_tos_score double precision,
    bullish_ratio double precision,
    advance_decline_ratio double precision,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE market_intelligence.market_breadth_snapshot OWNER TO rathore;

--
-- Name: market_regime_state; Type: TABLE; Schema: market_intelligence; Owner: rathore
--

CREATE TABLE market_intelligence.market_regime_state (
    trade_date date NOT NULL,
    regime_type text NOT NULL,
    confidence_score double precision,
    markup_pct double precision,
    markdown_pct double precision,
    accumulation_pct double precision,
    distribution_pct double precision,
    avg_tsi_score double precision,
    avg_atr_ratio double precision,
    next_regime_forecast text,
    transition_matrix_json jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE market_intelligence.market_regime_state OWNER TO rathore;

--
-- Name: meta_signal_results; Type: TABLE; Schema: market_intelligence; Owner: rathore
--

CREATE TABLE market_intelligence.meta_signal_results (
    trade_date date NOT NULL,
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    timeframe text NOT NULL,
    raw_signal_type text,
    adjusted_signal_type text,
    raw_tos_score double precision,
    adjusted_score double precision,
    regime_context text,
    sector_phase text,
    suppression_reason text,
    priority_rank integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE market_intelligence.meta_signal_results OWNER TO rathore;

--
-- Name: sector_heatmap; Type: TABLE; Schema: market_intelligence; Owner: rathore
--

CREATE TABLE market_intelligence.sector_heatmap (
    trade_date date NOT NULL,
    sector_name text NOT NULL,
    symbol_count integer,
    avg_tos_score double precision,
    avg_sms_score double precision,
    avg_tsi_score double precision,
    avg_inst_accumulation double precision,
    avg_inst_distribution double precision,
    sector_strength_score double precision,
    sector_phase text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE market_intelligence.sector_heatmap OWNER TO rathore;

--
-- Name: trade_execution_plan; Type: TABLE; Schema: market_intelligence; Owner: rathore
--

CREATE TABLE market_intelligence.trade_execution_plan (
    trade_date date NOT NULL,
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    timeframe text NOT NULL,
    signal_type text NOT NULL,
    priority_rank integer,
    sector_name text,
    allocated_capital double precision,
    entry_zone_low double precision,
    entry_zone_high double precision,
    stop_loss_level double precision,
    target_level double precision,
    risk_reward_ratio double precision,
    strategy_tag text,
    execution_status text DEFAULT 'PLANNED'::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    actual_entry_price double precision,
    entry_bar_ts timestamp without time zone,
    entry_tf_id bigint,
    expiry_bars integer,
    actual_exit_price double precision,
    exit_bar_ts timestamp without time zone,
    exit_tf_id bigint,
    exit_reason text,
    quantity double precision,
    filled_quantity double precision,
    execution_notes_json jsonb DEFAULT '{}'::jsonb,
    CONSTRAINT chk_trade_execution_plan_execution_status CHECK (((execution_status IS NULL) OR (execution_status = ANY (ARRAY['PLANNED'::text, 'OPEN'::text, 'FILLED'::text, 'CANCELLED'::text, 'REJECTED'::text, 'PARTIAL_EXIT'::text, 'CLOSED'::text]))))
);


ALTER TABLE market_intelligence.trade_execution_plan OWNER TO rathore;

--
-- Name: trade_outcome_attribution; Type: TABLE; Schema: market_intelligence; Owner: rathore
--

CREATE TABLE market_intelligence.trade_outcome_attribution (
    trade_date date NOT NULL,
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    timeframe text NOT NULL,
    signal_type text NOT NULL,
    market_regime text,
    side_preference text,
    market_alignment_score double precision,
    sector_alignment_score double precision,
    stock_vs_sector_rs_score double precision,
    stock_vs_market_rs_score double precision,
    sector_name text,
    strategy_tag text,
    outcome_status text NOT NULL,
    outcome_bucket text,
    quality_bucket text,
    realized_pnl double precision,
    mfe_pct double precision,
    mae_pct double precision,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE market_intelligence.trade_outcome_attribution OWNER TO rathore;

--
-- Name: trade_outcome_events; Type: TABLE; Schema: market_intelligence; Owner: rathore
--

CREATE TABLE market_intelligence.trade_outcome_events (
    trade_date date NOT NULL,
    instrument_id bigint NOT NULL,
    timeframe text NOT NULL,
    event_seq integer NOT NULL,
    event_type text NOT NULL,
    event_bar_ts timestamp without time zone,
    event_tf_id bigint,
    event_price double precision,
    event_json jsonb DEFAULT '{}'::jsonb,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE market_intelligence.trade_outcome_events OWNER TO rathore;

--
-- Name: trade_outcome_feedback; Type: TABLE; Schema: market_intelligence; Owner: rathore
--

CREATE TABLE market_intelligence.trade_outcome_feedback (
    signal_type text NOT NULL,
    timeframe text NOT NULL,
    market_regime text NOT NULL,
    side_preference text NOT NULL,
    trade_count integer NOT NULL,
    win_count integer NOT NULL,
    loss_count integer NOT NULL,
    target_hit_rate double precision,
    stop_hit_rate double precision,
    expiry_rate double precision,
    avg_realized_pnl double precision,
    avg_mfe_pct double precision,
    avg_mae_pct double precision,
    updated_at timestamp with time zone DEFAULT now(),
    avg_win_pnl double precision,
    avg_loss_pnl double precision,
    avg_trade_duration_bars double precision,
    ambiguous_rate double precision,
    open_rate double precision,
    expired_profit_rate double precision,
    expired_loss_rate double precision,
    avg_market_alignment_score double precision,
    avg_sector_alignment_score double precision,
    avg_stock_vs_sector_rs_score double precision,
    avg_stock_vs_market_rs_score double precision,
    feedback_json jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE market_intelligence.trade_outcome_feedback OWNER TO rathore;

--
-- Name: trade_outcomes; Type: TABLE; Schema: market_intelligence; Owner: rathore
--

CREATE TABLE market_intelligence.trade_outcomes (
    trade_date date NOT NULL,
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    timeframe text NOT NULL,
    signal_type text NOT NULL,
    execution_status text,
    outcome_status text NOT NULL,
    bars_elapsed integer,
    latest_bar_ts timestamp without time zone,
    latest_close double precision,
    latest_high double precision,
    latest_low double precision,
    stop_loss_level double precision,
    target_level double precision,
    entry_zone_low double precision,
    entry_zone_high double precision,
    realized_pnl double precision,
    outcome_detail_json jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    entry_price double precision,
    entry_bar_ts timestamp without time zone,
    entry_tf_id bigint,
    exit_price double precision,
    exit_bar_ts timestamp without time zone,
    exit_reason text,
    mfe_price double precision,
    mae_price double precision,
    mfe_pct double precision,
    mae_pct double precision,
    market_regime text,
    side_preference text,
    market_alignment_score double precision,
    sector_alignment_score double precision,
    stock_vs_sector_rs_score double precision,
    stock_vs_market_rs_score double precision,
    outcome_bucket text,
    quality_bucket text,
    entry_reference_mode text,
    exit_tf_id bigint,
    trade_duration_bars integer,
    trade_duration_label text,
    target_hit_bar_ts timestamp without time zone,
    stop_hit_bar_ts timestamp without time zone,
    ambiguous_bar_flag boolean DEFAULT false,
    mfe_bar_ts timestamp without time zone,
    mae_bar_ts timestamp without time zone,
    regime_at_entry_json jsonb DEFAULT '{}'::jsonb,
    path_metrics_json jsonb DEFAULT '{}'::jsonb,
    CONSTRAINT chk_trade_outcomes_outcome_bucket CHECK (((outcome_bucket IS NULL) OR (outcome_bucket = ANY (ARRAY['WIN'::text, 'LOSS'::text, 'EXPIRED'::text, 'EXPIRED_PROFIT'::text, 'EXPIRED_LOSS'::text, 'OPEN'::text, 'OPEN_PROFIT'::text, 'OPEN_LOSS'::text, 'AMBIGUOUS'::text, 'OTHER'::text])))),
    CONSTRAINT chk_trade_outcomes_outcome_status CHECK ((outcome_status = ANY (ARRAY['OPEN'::text, 'HIT_STOP'::text, 'HIT_TARGET'::text, 'EXPIRED'::text, 'AMBIGUOUS_BAR'::text])))
);


ALTER TABLE market_intelligence.trade_outcomes OWNER TO rathore;

--
-- Name: watchlist_alerts; Type: TABLE; Schema: market_intelligence; Owner: rathore
--

CREATE TABLE market_intelligence.watchlist_alerts (
    trade_date date NOT NULL,
    instrument_id bigint NOT NULL,
    timeframe text NOT NULL,
    symbol text NOT NULL,
    alert_type text NOT NULL,
    alert_message text NOT NULL,
    alert_status text NOT NULL,
    dedup_key text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE market_intelligence.watchlist_alerts OWNER TO rathore;

--
-- Name: watchlist_candidates; Type: TABLE; Schema: market_intelligence; Owner: rathore
--

CREATE TABLE market_intelligence.watchlist_candidates (
    trade_date date NOT NULL,
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    timeframe text NOT NULL,
    signal_type text NOT NULL,
    tos_score double precision,
    sector_name text,
    regime_context text,
    entry_zone_low double precision,
    entry_zone_high double precision,
    stop_loss_level double precision,
    target_level double precision,
    risk_reward_ratio double precision,
    alert_triggered boolean DEFAULT false,
    alert_sent_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE market_intelligence.watchlist_candidates OWNER TO rathore;

--
-- Name: eod_reconciliation_log; Type: TABLE; Schema: market_mcx; Owner: rathore
--

CREATE TABLE market_mcx.eod_reconciliation_log (
    reconciliation_id bigint NOT NULL,
    trade_date date NOT NULL,
    symbol text NOT NULL,
    timeframe text NOT NULL,
    prior_close numeric(18,6),
    official_close numeric(18,6),
    prior_high numeric(18,6),
    prior_low numeric(18,6),
    revised_high numeric(18,6),
    revised_low numeric(18,6),
    source_name text NOT NULL,
    action_taken text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE market_mcx.eod_reconciliation_log OWNER TO rathore;

--
-- Name: eod_reconciliation_log_reconciliation_id_seq; Type: SEQUENCE; Schema: market_mcx; Owner: rathore
--

CREATE SEQUENCE market_mcx.eod_reconciliation_log_reconciliation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE market_mcx.eod_reconciliation_log_reconciliation_id_seq OWNER TO rathore;

--
-- Name: eod_reconciliation_log_reconciliation_id_seq1; Type: SEQUENCE; Schema: market_mcx; Owner: rathore
--

CREATE SEQUENCE market_mcx.eod_reconciliation_log_reconciliation_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE market_mcx.eod_reconciliation_log_reconciliation_id_seq1 OWNER TO rathore;

--
-- Name: eod_reconciliation_log_reconciliation_id_seq1; Type: SEQUENCE OWNED BY; Schema: market_mcx; Owner: rathore
--

ALTER SEQUENCE market_mcx.eod_reconciliation_log_reconciliation_id_seq1 OWNED BY market_mcx.eod_reconciliation_log.reconciliation_id;


--
-- Name: market_candle_sma_state; Type: TABLE; Schema: market_mcx; Owner: rathore
--

CREATE TABLE market_mcx.market_candle_sma_state (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    sma_5_pos text,
    sma_10_pos text,
    sma_20_pos text,
    sma_50_pos text,
    sma_100_pos text,
    sma_200_pos text,
    sma_pressure_index integer,
    sma_bull_count integer,
    sma_bear_count integer,
    sma_spread numeric(18,6),
    sma_compression_ratio numeric(18,6),
    sma_compression_score numeric(18,6),
    sma_compression_state text,
    sma_compression_duration integer,
    sma_order_structure_score integer,
    sma_order_structure_state text,
    sma_order_structure_duration integer,
    sma_in_range_count integer,
    sma20_trend_direction text,
    sma20_trend_run_length integer,
    sma5_relative_lis_length integer,
    sma10_relative_lis_length integer,
    close_open_dominance_count integer,
    price_to_sma_5_pct numeric(18,6),
    price_to_sma_10_pct numeric(18,6),
    price_to_sma_20_pct numeric(18,6),
    price_to_sma_50_pct numeric(18,6),
    price_to_sma_100_pct numeric(18,6),
    price_to_sma_200_pct numeric(18,6),
    sma_5_to_10_pct numeric(18,6),
    sma_5_to_20_pct numeric(18,6),
    sma_10_to_20_pct numeric(18,6),
    sma_20_to_50_pct numeric(18,6),
    sma_50_to_200_pct numeric(18,6),
    sma5_cross_sma10 text,
    sma5_cross_sma20 text,
    sma10_cross_sma20 text,
    sma20_cross_sma50 text,
    sma50_cross_sma200 text,
    sma_cross_events text[],
    last_cross_family text,
    bars_since_last_cross integer,
    sma_crossover_momentum_raw_score integer,
    sma_crossover_momentum_normalized_score numeric(18,6),
    sma_crossover_momentum_state text,
    sma_5_turn_direction text,
    sma_10_turn_direction text,
    sma_20_turn_direction text,
    sma_50_turn_direction text,
    sma_100_turn_direction text,
    sma_200_turn_direction text,
    sma_5_turn_score numeric(18,6),
    sma_10_turn_score numeric(18,6),
    sma_20_turn_score numeric(18,6),
    sma_50_turn_score numeric(18,6),
    sma_100_turn_score numeric(18,6),
    sma_200_turn_score numeric(18,6),
    sma5_anchor_tf_id bigint,
    sma10_anchor_tf_id bigint,
    sma20_anchor_tf_id bigint,
    sma5_anchor_bar_start_ts timestamp without time zone,
    sma10_anchor_bar_start_ts timestamp without time zone,
    sma20_anchor_bar_start_ts timestamp without time zone,
    sma5_linreg_slope numeric(18,6),
    sma10_linreg_slope numeric(18,6),
    sma20_linreg_slope numeric(18,6),
    sma5_angle_deg numeric(18,6),
    sma10_angle_deg numeric(18,6),
    sma20_angle_deg numeric(18,6),
    sma5_angle_label text,
    sma10_angle_label text,
    sma20_angle_label text,
    sma5_r2 numeric(18,6),
    sma10_r2 numeric(18,6),
    sma20_r2 numeric(18,6),
    sma5_acceleration_state text,
    sma10_acceleration_state text,
    sma20_acceleration_state text,
    sma5_recent_vs_overall text,
    sma10_recent_vs_overall text,
    sma20_recent_vs_overall text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE market_mcx.market_candle_sma_state OWNER TO rathore;

--
-- Name: market_day_status; Type: TABLE; Schema: market_mcx; Owner: rathore
--

CREATE TABLE market_mcx.market_day_status (
    trade_date date NOT NULL,
    equity_eod_downloaded boolean DEFAULT false NOT NULL,
    index_eod_downloaded boolean DEFAULT false NOT NULL,
    equity_rows_loaded integer DEFAULT 0 NOT NULL,
    index_rows_loaded integer DEFAULT 0 NOT NULL,
    reconciliation_complete boolean DEFAULT false NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    error_message text,
    finalized_at timestamp without time zone,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE market_mcx.market_day_status OWNER TO rathore;

--
-- Name: eod_reconciliation_log; Type: TABLE; Schema: market_nfo; Owner: rathore
--

CREATE TABLE market_nfo.eod_reconciliation_log (
    reconciliation_id bigint NOT NULL,
    trade_date date NOT NULL,
    symbol text NOT NULL,
    timeframe text NOT NULL,
    prior_close numeric(18,6),
    official_close numeric(18,6),
    prior_high numeric(18,6),
    prior_low numeric(18,6),
    revised_high numeric(18,6),
    revised_low numeric(18,6),
    source_name text NOT NULL,
    action_taken text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE market_nfo.eod_reconciliation_log OWNER TO rathore;

--
-- Name: eod_reconciliation_log_reconciliation_id_seq; Type: SEQUENCE; Schema: market_nfo; Owner: rathore
--

CREATE SEQUENCE market_nfo.eod_reconciliation_log_reconciliation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE market_nfo.eod_reconciliation_log_reconciliation_id_seq OWNER TO rathore;

--
-- Name: eod_reconciliation_log_reconciliation_id_seq1; Type: SEQUENCE; Schema: market_nfo; Owner: rathore
--

CREATE SEQUENCE market_nfo.eod_reconciliation_log_reconciliation_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE market_nfo.eod_reconciliation_log_reconciliation_id_seq1 OWNER TO rathore;

--
-- Name: eod_reconciliation_log_reconciliation_id_seq1; Type: SEQUENCE OWNED BY; Schema: market_nfo; Owner: rathore
--

ALTER SEQUENCE market_nfo.eod_reconciliation_log_reconciliation_id_seq1 OWNED BY market_nfo.eod_reconciliation_log.reconciliation_id;


--
-- Name: market_candle_sma_state; Type: TABLE; Schema: market_nfo; Owner: rathore
--

CREATE TABLE market_nfo.market_candle_sma_state (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    sma_5_pos text,
    sma_10_pos text,
    sma_20_pos text,
    sma_50_pos text,
    sma_100_pos text,
    sma_200_pos text,
    sma_pressure_index integer,
    sma_bull_count integer,
    sma_bear_count integer,
    sma_spread numeric(18,6),
    sma_compression_ratio numeric(18,6),
    sma_compression_score numeric(18,6),
    sma_compression_state text,
    sma_compression_duration integer,
    sma_order_structure_score integer,
    sma_order_structure_state text,
    sma_order_structure_duration integer,
    sma_in_range_count integer,
    sma20_trend_direction text,
    sma20_trend_run_length integer,
    sma5_relative_lis_length integer,
    sma10_relative_lis_length integer,
    close_open_dominance_count integer,
    price_to_sma_5_pct numeric(18,6),
    price_to_sma_10_pct numeric(18,6),
    price_to_sma_20_pct numeric(18,6),
    price_to_sma_50_pct numeric(18,6),
    price_to_sma_100_pct numeric(18,6),
    price_to_sma_200_pct numeric(18,6),
    sma_5_to_10_pct numeric(18,6),
    sma_5_to_20_pct numeric(18,6),
    sma_10_to_20_pct numeric(18,6),
    sma_20_to_50_pct numeric(18,6),
    sma_50_to_200_pct numeric(18,6),
    sma5_cross_sma10 text,
    sma5_cross_sma20 text,
    sma10_cross_sma20 text,
    sma20_cross_sma50 text,
    sma50_cross_sma200 text,
    sma_cross_events text[],
    last_cross_family text,
    bars_since_last_cross integer,
    sma_crossover_momentum_raw_score integer,
    sma_crossover_momentum_normalized_score numeric(18,6),
    sma_crossover_momentum_state text,
    sma_5_turn_direction text,
    sma_10_turn_direction text,
    sma_20_turn_direction text,
    sma_50_turn_direction text,
    sma_100_turn_direction text,
    sma_200_turn_direction text,
    sma_5_turn_score numeric(18,6),
    sma_10_turn_score numeric(18,6),
    sma_20_turn_score numeric(18,6),
    sma_50_turn_score numeric(18,6),
    sma_100_turn_score numeric(18,6),
    sma_200_turn_score numeric(18,6),
    sma5_anchor_tf_id bigint,
    sma10_anchor_tf_id bigint,
    sma20_anchor_tf_id bigint,
    sma5_anchor_bar_start_ts timestamp without time zone,
    sma10_anchor_bar_start_ts timestamp without time zone,
    sma20_anchor_bar_start_ts timestamp without time zone,
    sma5_linreg_slope numeric(18,6),
    sma10_linreg_slope numeric(18,6),
    sma20_linreg_slope numeric(18,6),
    sma5_angle_deg numeric(18,6),
    sma10_angle_deg numeric(18,6),
    sma20_angle_deg numeric(18,6),
    sma5_angle_label text,
    sma10_angle_label text,
    sma20_angle_label text,
    sma5_r2 numeric(18,6),
    sma10_r2 numeric(18,6),
    sma20_r2 numeric(18,6),
    sma5_acceleration_state text,
    sma10_acceleration_state text,
    sma20_acceleration_state text,
    sma5_recent_vs_overall text,
    sma10_recent_vs_overall text,
    sma20_recent_vs_overall text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE market_nfo.market_candle_sma_state OWNER TO rathore;

--
-- Name: market_day_status; Type: TABLE; Schema: market_nfo; Owner: rathore
--

CREATE TABLE market_nfo.market_day_status (
    trade_date date NOT NULL,
    equity_eod_downloaded boolean DEFAULT false NOT NULL,
    index_eod_downloaded boolean DEFAULT false NOT NULL,
    equity_rows_loaded integer DEFAULT 0 NOT NULL,
    index_rows_loaded integer DEFAULT 0 NOT NULL,
    reconciliation_complete boolean DEFAULT false NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    error_message text,
    finalized_at timestamp without time zone,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE market_nfo.market_day_status OWNER TO rathore;

--
-- Name: eod_reconciliation_log; Type: TABLE; Schema: market_nse; Owner: rathore
--

CREATE TABLE market_nse.eod_reconciliation_log (
    reconciliation_id bigint NOT NULL,
    trade_date date NOT NULL,
    symbol text NOT NULL,
    timeframe text NOT NULL,
    prior_close numeric(18,6),
    official_close numeric(18,6),
    prior_high numeric(18,6),
    prior_low numeric(18,6),
    revised_high numeric(18,6),
    revised_low numeric(18,6),
    source_name text NOT NULL,
    action_taken text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE market_nse.eod_reconciliation_log OWNER TO rathore;

--
-- Name: eod_reconciliation_log_reconciliation_id_seq; Type: SEQUENCE; Schema: market_nse; Owner: rathore
--

CREATE SEQUENCE market_nse.eod_reconciliation_log_reconciliation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE market_nse.eod_reconciliation_log_reconciliation_id_seq OWNER TO rathore;

--
-- Name: eod_reconciliation_log_reconciliation_id_seq1; Type: SEQUENCE; Schema: market_nse; Owner: rathore
--

CREATE SEQUENCE market_nse.eod_reconciliation_log_reconciliation_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE market_nse.eod_reconciliation_log_reconciliation_id_seq1 OWNER TO rathore;

--
-- Name: eod_reconciliation_log_reconciliation_id_seq1; Type: SEQUENCE OWNED BY; Schema: market_nse; Owner: rathore
--

ALTER SEQUENCE market_nse.eod_reconciliation_log_reconciliation_id_seq1 OWNED BY market_nse.eod_reconciliation_log.reconciliation_id;


--
-- Name: hour_candle_gap_audit; Type: TABLE; Schema: market_nse; Owner: rathore
--

CREATE TABLE market_nse.hour_candle_gap_audit (
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    exchange_code text NOT NULL,
    trade_date date NOT NULL,
    timeframe text DEFAULT 'hour'::text NOT NULL,
    session_open time without time zone NOT NULL,
    session_close time without time zone NOT NULL,
    expected_count integer NOT NULL,
    actual_count integer NOT NULL,
    expected_slots_json jsonb DEFAULT '[]'::jsonb NOT NULL,
    missing_slots_json jsonb DEFAULT '[]'::jsonb NOT NULL,
    csv_available boolean DEFAULT false NOT NULL,
    rest_attempted boolean DEFAULT false NOT NULL,
    repair_status text DEFAULT 'DETECTED'::text NOT NULL,
    repair_source text,
    last_repaired_at timestamp with time zone,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE market_nse.hour_candle_gap_audit OWNER TO rathore;

--
-- Name: market_candle_sma_state; Type: TABLE; Schema: market_nse; Owner: rathore
--

CREATE TABLE market_nse.market_candle_sma_state (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    sma_5_pos text,
    sma_10_pos text,
    sma_20_pos text,
    sma_50_pos text,
    sma_100_pos text,
    sma_200_pos text,
    sma_pressure_index integer,
    sma_bull_count integer,
    sma_bear_count integer,
    sma_spread numeric(18,6),
    sma_compression_ratio numeric(18,6),
    sma_compression_score numeric(18,6),
    sma_compression_state text,
    sma_compression_duration integer,
    sma_order_structure_score integer,
    sma_order_structure_state text,
    sma_order_structure_duration integer,
    sma_in_range_count integer,
    sma20_trend_direction text,
    sma20_trend_run_length integer,
    sma5_relative_lis_length integer,
    sma10_relative_lis_length integer,
    close_open_dominance_count integer,
    price_to_sma_5_pct numeric(18,6),
    price_to_sma_10_pct numeric(18,6),
    price_to_sma_20_pct numeric(18,6),
    price_to_sma_50_pct numeric(18,6),
    price_to_sma_100_pct numeric(18,6),
    price_to_sma_200_pct numeric(18,6),
    sma_5_to_10_pct numeric(18,6),
    sma_5_to_20_pct numeric(18,6),
    sma_10_to_20_pct numeric(18,6),
    sma_20_to_50_pct numeric(18,6),
    sma_50_to_200_pct numeric(18,6),
    sma5_cross_sma10 text,
    sma5_cross_sma20 text,
    sma10_cross_sma20 text,
    sma20_cross_sma50 text,
    sma50_cross_sma200 text,
    sma_cross_events text[],
    last_cross_family text,
    bars_since_last_cross integer,
    sma_crossover_momentum_raw_score integer,
    sma_crossover_momentum_normalized_score numeric(18,6),
    sma_crossover_momentum_state text,
    sma_5_turn_direction text,
    sma_10_turn_direction text,
    sma_20_turn_direction text,
    sma_50_turn_direction text,
    sma_100_turn_direction text,
    sma_200_turn_direction text,
    sma_5_turn_score numeric(18,6),
    sma_10_turn_score numeric(18,6),
    sma_20_turn_score numeric(18,6),
    sma_50_turn_score numeric(18,6),
    sma_100_turn_score numeric(18,6),
    sma_200_turn_score numeric(18,6),
    sma5_anchor_tf_id bigint,
    sma10_anchor_tf_id bigint,
    sma20_anchor_tf_id bigint,
    sma5_anchor_bar_start_ts timestamp without time zone,
    sma10_anchor_bar_start_ts timestamp without time zone,
    sma20_anchor_bar_start_ts timestamp without time zone,
    sma5_linreg_slope numeric(18,6),
    sma10_linreg_slope numeric(18,6),
    sma20_linreg_slope numeric(18,6),
    sma5_angle_deg numeric(18,6),
    sma10_angle_deg numeric(18,6),
    sma20_angle_deg numeric(18,6),
    sma5_angle_label text,
    sma10_angle_label text,
    sma20_angle_label text,
    sma5_r2 numeric(18,6),
    sma10_r2 numeric(18,6),
    sma20_r2 numeric(18,6),
    sma5_acceleration_state text,
    sma10_acceleration_state text,
    sma20_acceleration_state text,
    sma5_recent_vs_overall text,
    sma10_recent_vs_overall text,
    sma20_recent_vs_overall text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE market_nse.market_candle_sma_state OWNER TO rathore;

--
-- Name: market_day_status; Type: TABLE; Schema: market_nse; Owner: rathore
--

CREATE TABLE market_nse.market_day_status (
    trade_date date NOT NULL,
    equity_eod_downloaded boolean DEFAULT false NOT NULL,
    index_eod_downloaded boolean DEFAULT false NOT NULL,
    equity_rows_loaded integer DEFAULT 0 NOT NULL,
    index_rows_loaded integer DEFAULT 0 NOT NULL,
    reconciliation_complete boolean DEFAULT false NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    error_message text,
    finalized_at timestamp without time zone,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE market_nse.market_day_status OWNER TO rathore;

--
-- Name: instrument_master; Type: TABLE; Schema: mcx_exchange_symbol; Owner: rathore
--

CREATE TABLE mcx_exchange_symbol.instrument_master (
    instrument_id bigint NOT NULL,
    instrument_key text NOT NULL,
    symbol text NOT NULL,
    trading_symbol text,
    instrument_type text NOT NULL,
    asset_class text DEFAULT 'COMMODITY_DERIVATIVE'::text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    tick_size numeric(18,8),
    lot_size integer,
    currency_code text DEFAULT 'INR'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE mcx_exchange_symbol.instrument_master OWNER TO rathore;

--
-- Name: instrument_master_derivative; Type: TABLE; Schema: mcx_exchange_symbol; Owner: rathore
--

CREATE TABLE mcx_exchange_symbol.instrument_master_derivative (
    instrument_id bigint NOT NULL,
    token text,
    expiry_date date,
    option_type text,
    strike_price numeric(18,4),
    underlying_symbol text,
    gngd text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE mcx_exchange_symbol.instrument_master_derivative OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE; Schema: mcx_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE mcx_exchange_symbol.instrument_master_instrument_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mcx_exchange_symbol.instrument_master_instrument_id_seq OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: mcx_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE mcx_exchange_symbol.instrument_master_instrument_id_seq OWNED BY mcx_exchange_symbol.instrument_master.instrument_id;


--
-- Name: phase0_run_audit; Type: TABLE; Schema: mcx_exchange_symbol; Owner: rathore
--

CREATE TABLE mcx_exchange_symbol.phase0_run_audit (
    run_id bigint NOT NULL,
    step_code text NOT NULL,
    status text NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    rows_inserted integer DEFAULT 0 NOT NULL,
    rows_updated integer DEFAULT 0 NOT NULL,
    rows_rejected integer DEFAULT 0 NOT NULL,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    error_message text
);


ALTER TABLE mcx_exchange_symbol.phase0_run_audit OWNER TO rathore;

--
-- Name: phase0_run_audit_run_id_seq; Type: SEQUENCE; Schema: mcx_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE mcx_exchange_symbol.phase0_run_audit_run_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mcx_exchange_symbol.phase0_run_audit_run_id_seq OWNER TO rathore;

--
-- Name: phase0_run_audit_run_id_seq; Type: SEQUENCE OWNED BY; Schema: mcx_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE mcx_exchange_symbol.phase0_run_audit_run_id_seq OWNED BY mcx_exchange_symbol.phase0_run_audit.run_id;


--
-- Name: raw_ticks_tick_id_seq; Type: SEQUENCE; Schema: mcx_tick_data; Owner: rathore
--

CREATE SEQUENCE mcx_tick_data.raw_ticks_tick_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mcx_tick_data.raw_ticks_tick_id_seq OWNER TO rathore;

--
-- Name: raw_ticks; Type: TABLE; Schema: mcx_tick_data; Owner: rathore
--

CREATE TABLE mcx_tick_data.raw_ticks (
    tick_id bigint DEFAULT nextval('mcx_tick_data.raw_ticks_tick_id_seq'::regclass) NOT NULL,
    provider text DEFAULT 'SHOONYA'::text NOT NULL,
    exchange text NOT NULL,
    asset_class text,
    symbol text NOT NULL,
    trading_symbol text,
    token text NOT NULL,
    event_type text,
    event_ts timestamp without time zone,
    ingest_ts timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_price numeric(18,6),
    last_qty numeric(18,6),
    volume numeric(18,6),
    open_price numeric(18,6),
    high_price numeric(18,6),
    low_price numeric(18,6),
    close_price numeric(18,6),
    avg_price numeric(18,6),
    open_interest numeric(18,6),
    raw_payload jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE mcx_tick_data.raw_ticks OWNER TO rathore;

--
-- Name: realtime_5m_bar; Type: TABLE; Schema: mcx_tick_data; Owner: rathore
--

CREATE TABLE mcx_tick_data.realtime_5m_bar (
    provider text DEFAULT 'SHOONYA'::text NOT NULL,
    exchange text NOT NULL,
    asset_class text,
    symbol text NOT NULL,
    trading_symbol text,
    token text,
    bar_start_ts timestamp without time zone NOT NULL,
    bar_end_ts timestamp without time zone NOT NULL,
    open_price numeric(18,6) NOT NULL,
    high_price numeric(18,6) NOT NULL,
    low_price numeric(18,6) NOT NULL,
    close_price numeric(18,6) NOT NULL,
    volume numeric(18,6),
    tick_count integer DEFAULT 0 NOT NULL,
    status text DEFAULT 'LIVE_PARTIAL'::text NOT NULL,
    source_session_id text,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE mcx_tick_data.realtime_5m_bar OWNER TO rathore;

--
-- Name: csv_ingestion_audit; Type: TABLE; Schema: meta_data; Owner: rathore
--

CREATE TABLE meta_data.csv_ingestion_audit (
    id bigint NOT NULL,
    file_name text,
    file_hash text,
    status text,
    rows_processed integer,
    error text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE meta_data.csv_ingestion_audit OWNER TO rathore;

--
-- Name: csv_ingestion_audit_id_seq; Type: SEQUENCE; Schema: meta_data; Owner: rathore
--

CREATE SEQUENCE meta_data.csv_ingestion_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE meta_data.csv_ingestion_audit_id_seq OWNER TO rathore;

--
-- Name: csv_ingestion_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: meta_data; Owner: rathore
--

ALTER SEQUENCE meta_data.csv_ingestion_audit_id_seq OWNED BY meta_data.csv_ingestion_audit.id;


--
-- Name: engine_error_log; Type: TABLE; Schema: meta_data; Owner: rathore
--

CREATE TABLE meta_data.engine_error_log (
    error_id bigint NOT NULL,
    engine_name text NOT NULL,
    instrument_id bigint,
    timeframe text,
    trade_date date,
    tf_id bigint,
    bar_start_ts timestamp without time zone,
    error_type text NOT NULL,
    error_message text NOT NULL,
    payload_json jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE meta_data.engine_error_log OWNER TO rathore;

--
-- Name: engine_error_log_error_id_seq; Type: SEQUENCE; Schema: meta_data; Owner: rathore
--

CREATE SEQUENCE meta_data.engine_error_log_error_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE meta_data.engine_error_log_error_id_seq OWNER TO rathore;

--
-- Name: engine_error_log_error_id_seq; Type: SEQUENCE OWNED BY; Schema: meta_data; Owner: rathore
--

ALTER SEQUENCE meta_data.engine_error_log_error_id_seq OWNED BY meta_data.engine_error_log.error_id;


--
-- Name: engine_run_tracker; Type: TABLE; Schema: meta_data; Owner: rathore
--

CREATE TABLE meta_data.engine_run_tracker (
    tracker_id bigint NOT NULL,
    engine_name text NOT NULL,
    instrument_id bigint,
    timeframe text NOT NULL,
    trade_date date,
    status text NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    from_tf_id bigint,
    last_tf_id_processed bigint,
    from_bar_start_ts timestamp without time zone,
    last_bar_start_ts_processed timestamp without time zone,
    source_revision_max integer,
    dependency_signature text,
    rows_upserted integer DEFAULT 0 NOT NULL,
    error_message text,
    context_json jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    payload_json jsonb
);


ALTER TABLE meta_data.engine_run_tracker OWNER TO rathore;

--
-- Name: engine_run_tracker_tracker_id_seq; Type: SEQUENCE; Schema: meta_data; Owner: rathore
--

CREATE SEQUENCE meta_data.engine_run_tracker_tracker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE meta_data.engine_run_tracker_tracker_id_seq OWNER TO rathore;

--
-- Name: engine_run_tracker_tracker_id_seq; Type: SEQUENCE OWNED BY; Schema: meta_data; Owner: rathore
--

ALTER SEQUENCE meta_data.engine_run_tracker_tracker_id_seq OWNED BY meta_data.engine_run_tracker.tracker_id;


--
-- Name: htf_rebuild_watermark; Type: TABLE; Schema: meta_data; Owner: rathore
--

CREATE TABLE meta_data.htf_rebuild_watermark (
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    last_day_candle_ts timestamp with time zone NOT NULL,
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE meta_data.htf_rebuild_watermark OWNER TO rathore;

--
-- Name: nse_market_holiday; Type: TABLE; Schema: meta_data; Owner: rathore
--

CREATE TABLE meta_data.nse_market_holiday (
    trade_date date NOT NULL,
    exchange_code text DEFAULT 'NSE'::text NOT NULL,
    holiday_type text NOT NULL,
    description text,
    is_confirmed boolean DEFAULT true NOT NULL,
    source text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE meta_data.nse_market_holiday OWNER TO rathore;

--
-- Name: pipeline_run_metrics; Type: TABLE; Schema: meta_data; Owner: rathore
--

CREATE TABLE meta_data.pipeline_run_metrics (
    run_id bigint NOT NULL,
    step_name character varying(100) NOT NULL,
    started_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp with time zone,
    exchange_code character varying(10),
    trade_date date,
    rebuild_mode character varying(20),
    work_items integer DEFAULT 0 NOT NULL,
    items_processed integer DEFAULT 0 NOT NULL,
    metric_rows_written integer DEFAULT 0 NOT NULL,
    nbar_rows_written integer DEFAULT 0 NOT NULL,
    runtime_validation_errors integer DEFAULT 0 NOT NULL,
    runtime_validation_warnings integer DEFAULT 0 NOT NULL,
    pivot_chain_error_rows integer DEFAULT 0 NOT NULL,
    hard_failures integer DEFAULT 0 NOT NULL,
    write_failures integer DEFAULT 0 NOT NULL,
    status character varying(20) NOT NULL,
    summary_json jsonb
);


ALTER TABLE meta_data.pipeline_run_metrics OWNER TO rathore;

--
-- Name: pipeline_run_metrics_run_id_seq; Type: SEQUENCE; Schema: meta_data; Owner: rathore
--

CREATE SEQUENCE meta_data.pipeline_run_metrics_run_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE meta_data.pipeline_run_metrics_run_id_seq OWNER TO rathore;

--
-- Name: pipeline_run_metrics_run_id_seq; Type: SEQUENCE OWNED BY; Schema: meta_data; Owner: rathore
--

ALTER SEQUENCE meta_data.pipeline_run_metrics_run_id_seq OWNED BY meta_data.pipeline_run_metrics.run_id;


--
-- Name: shoonya_api_call_audit; Type: TABLE; Schema: meta_data; Owner: rathore
--

CREATE TABLE meta_data.shoonya_api_call_audit (
    shoonya_api_call_audit_id bigint NOT NULL,
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    exchange_code text NOT NULL,
    timeframe text NOT NULL,
    request_from_ts timestamp without time zone,
    request_to_ts timestamp without time zone,
    calls_made integer DEFAULT 0 NOT NULL,
    retries_count integer DEFAULT 0 NOT NULL,
    candles_fetched integer DEFAULT 0 NOT NULL,
    gaps_detected integer DEFAULT 0 NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    status text NOT NULL,
    metrics_json jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE meta_data.shoonya_api_call_audit OWNER TO rathore;

--
-- Name: shoonya_api_call_audit_shoonya_api_call_audit_id_seq; Type: SEQUENCE; Schema: meta_data; Owner: rathore
--

CREATE SEQUENCE meta_data.shoonya_api_call_audit_shoonya_api_call_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE meta_data.shoonya_api_call_audit_shoonya_api_call_audit_id_seq OWNER TO rathore;

--
-- Name: shoonya_api_call_audit_shoonya_api_call_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: meta_data; Owner: rathore
--

ALTER SEQUENCE meta_data.shoonya_api_call_audit_shoonya_api_call_audit_id_seq OWNED BY meta_data.shoonya_api_call_audit.shoonya_api_call_audit_id;


--
-- Name: sma_state_checkpoint; Type: TABLE; Schema: meta_data; Owner: rathore
--

CREATE TABLE meta_data.sma_state_checkpoint (
    schema_name text NOT NULL,
    instrument_id bigint NOT NULL,
    timeframe public.timeframe_enum NOT NULL,
    max_tf_id bigint NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE meta_data.sma_state_checkpoint OWNER TO rathore;

--
-- Name: csv_ingestion_audit; Type: TABLE; Schema: metadata; Owner: rathore
--

CREATE TABLE metadata.csv_ingestion_audit (
    id integer NOT NULL,
    file_name text NOT NULL,
    file_hash text,
    type text NOT NULL,
    status text NOT NULL,
    rows_processed integer DEFAULT 0 NOT NULL,
    error_message text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE metadata.csv_ingestion_audit OWNER TO rathore;

--
-- Name: csv_ingestion_audit_id_seq; Type: SEQUENCE; Schema: metadata; Owner: rathore
--

CREATE SEQUENCE metadata.csv_ingestion_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE metadata.csv_ingestion_audit_id_seq OWNER TO rathore;

--
-- Name: csv_ingestion_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: metadata; Owner: rathore
--

ALTER SEQUENCE metadata.csv_ingestion_audit_id_seq OWNED BY metadata.csv_ingestion_audit.id;


--
-- Name: instrument_bootstrap_audit; Type: TABLE; Schema: metadata; Owner: rathore
--

CREATE TABLE metadata.instrument_bootstrap_audit (
    instrument_bootstrap_audit_id bigint CONSTRAINT instrument_bootstrap_audit_instrument_bootstrap_audit__not_null NOT NULL,
    step_name text NOT NULL,
    substep_name text NOT NULL,
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    exchange_code text NOT NULL,
    source_name text NOT NULL,
    requested_timeframe text,
    actual_timeframes_json jsonb DEFAULT '[]'::jsonb NOT NULL,
    requested_from_date date,
    requested_to_date date,
    rows_upserted integer DEFAULT 0 NOT NULL,
    api_calls integer DEFAULT 0 NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    status text NOT NULL,
    error_message text,
    metrics_json jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE metadata.instrument_bootstrap_audit OWNER TO rathore;

--
-- Name: instrument_bootstrap_audit_instrument_bootstrap_audit_id_seq; Type: SEQUENCE; Schema: metadata; Owner: rathore
--

CREATE SEQUENCE metadata.instrument_bootstrap_audit_instrument_bootstrap_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE metadata.instrument_bootstrap_audit_instrument_bootstrap_audit_id_seq OWNER TO rathore;

--
-- Name: instrument_bootstrap_audit_instrument_bootstrap_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: metadata; Owner: rathore
--

ALTER SEQUENCE metadata.instrument_bootstrap_audit_instrument_bootstrap_audit_id_seq OWNED BY metadata.instrument_bootstrap_audit.instrument_bootstrap_audit_id;


--
-- Name: pipeline_step_run_audit; Type: TABLE; Schema: metadata; Owner: rathore
--

CREATE TABLE metadata.pipeline_step_run_audit (
    run_audit_id bigint NOT NULL,
    step_name text NOT NULL,
    substep_name text,
    run_id text,
    trade_date date,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    status text NOT NULL,
    symbols_count integer DEFAULT 0 NOT NULL,
    instruments_count integer DEFAULT 0 NOT NULL,
    rows_inserted integer DEFAULT 0 NOT NULL,
    rows_updated integer DEFAULT 0 NOT NULL,
    rows_deleted integer DEFAULT 0 NOT NULL,
    files_processed integer DEFAULT 0 NOT NULL,
    api_calls integer DEFAULT 0 NOT NULL,
    error_message text,
    metrics_json jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE metadata.pipeline_step_run_audit OWNER TO rathore;

--
-- Name: pipeline_step_run_audit_run_audit_id_seq; Type: SEQUENCE; Schema: metadata; Owner: rathore
--

CREATE SEQUENCE metadata.pipeline_step_run_audit_run_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE metadata.pipeline_step_run_audit_run_audit_id_seq OWNER TO rathore;

--
-- Name: pipeline_step_run_audit_run_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: metadata; Owner: rathore
--

ALTER SEQUENCE metadata.pipeline_step_run_audit_run_audit_id_seq OWNED BY metadata.pipeline_step_run_audit.run_audit_id;


--
-- Name: instrument_master; Type: TABLE; Schema: nfo_exchange_symbol; Owner: rathore
--

CREATE TABLE nfo_exchange_symbol.instrument_master (
    instrument_id bigint NOT NULL,
    instrument_key text NOT NULL,
    symbol text NOT NULL,
    trading_symbol text,
    instrument_type text NOT NULL,
    asset_class text DEFAULT 'DERIVATIVE'::text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    tick_size numeric(18,8),
    lot_size integer,
    currency_code text DEFAULT 'INR'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE nfo_exchange_symbol.instrument_master OWNER TO rathore;

--
-- Name: instrument_master_derivative; Type: TABLE; Schema: nfo_exchange_symbol; Owner: rathore
--

CREATE TABLE nfo_exchange_symbol.instrument_master_derivative (
    instrument_id bigint NOT NULL,
    nse_underlying_instrument_id bigint,
    token text,
    expiry_date date,
    option_type text,
    strike_price numeric(18,4),
    settlement_type text,
    underlying_symbol text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE nfo_exchange_symbol.instrument_master_derivative OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE; Schema: nfo_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE nfo_exchange_symbol.instrument_master_instrument_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nfo_exchange_symbol.instrument_master_instrument_id_seq OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: nfo_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE nfo_exchange_symbol.instrument_master_instrument_id_seq OWNED BY nfo_exchange_symbol.instrument_master.instrument_id;


--
-- Name: phase0_run_audit; Type: TABLE; Schema: nfo_exchange_symbol; Owner: rathore
--

CREATE TABLE nfo_exchange_symbol.phase0_run_audit (
    run_id bigint NOT NULL,
    step_code text NOT NULL,
    status text NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    rows_inserted integer DEFAULT 0 NOT NULL,
    rows_updated integer DEFAULT 0 NOT NULL,
    rows_rejected integer DEFAULT 0 NOT NULL,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    error_message text
);


ALTER TABLE nfo_exchange_symbol.phase0_run_audit OWNER TO rathore;

--
-- Name: phase0_run_audit_run_id_seq; Type: SEQUENCE; Schema: nfo_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE nfo_exchange_symbol.phase0_run_audit_run_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nfo_exchange_symbol.phase0_run_audit_run_id_seq OWNER TO rathore;

--
-- Name: phase0_run_audit_run_id_seq; Type: SEQUENCE OWNED BY; Schema: nfo_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE nfo_exchange_symbol.phase0_run_audit_run_id_seq OWNED BY nfo_exchange_symbol.phase0_run_audit.run_id;


--
-- Name: raw_ticks_tick_id_seq; Type: SEQUENCE; Schema: nfo_tick_data; Owner: rathore
--

CREATE SEQUENCE nfo_tick_data.raw_ticks_tick_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nfo_tick_data.raw_ticks_tick_id_seq OWNER TO rathore;

--
-- Name: raw_ticks; Type: TABLE; Schema: nfo_tick_data; Owner: rathore
--

CREATE TABLE nfo_tick_data.raw_ticks (
    tick_id bigint DEFAULT nextval('nfo_tick_data.raw_ticks_tick_id_seq'::regclass) NOT NULL,
    provider text DEFAULT 'SHOONYA'::text NOT NULL,
    exchange text NOT NULL,
    asset_class text,
    symbol text NOT NULL,
    trading_symbol text,
    token text NOT NULL,
    event_type text,
    event_ts timestamp without time zone,
    ingest_ts timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_price numeric(18,6),
    last_qty numeric(18,6),
    volume numeric(18,6),
    open_price numeric(18,6),
    high_price numeric(18,6),
    low_price numeric(18,6),
    close_price numeric(18,6),
    avg_price numeric(18,6),
    open_interest numeric(18,6),
    raw_payload jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE nfo_tick_data.raw_ticks OWNER TO rathore;

--
-- Name: realtime_5m_bar; Type: TABLE; Schema: nfo_tick_data; Owner: rathore
--

CREATE TABLE nfo_tick_data.realtime_5m_bar (
    provider text DEFAULT 'SHOONYA'::text NOT NULL,
    exchange text NOT NULL,
    asset_class text,
    symbol text NOT NULL,
    trading_symbol text,
    token text,
    bar_start_ts timestamp without time zone NOT NULL,
    bar_end_ts timestamp without time zone NOT NULL,
    open_price numeric(18,6) NOT NULL,
    high_price numeric(18,6) NOT NULL,
    low_price numeric(18,6) NOT NULL,
    close_price numeric(18,6) NOT NULL,
    volume numeric(18,6),
    tick_count integer DEFAULT 0 NOT NULL,
    status text DEFAULT 'LIVE_PARTIAL'::text NOT NULL,
    source_session_id text,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE nfo_tick_data.realtime_5m_bar OWNER TO rathore;

--
-- Name: index_constituent_map; Type: TABLE; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE TABLE nse_exchange_symbol.index_constituent_map (
    index_id bigint NOT NULL,
    instrument_id bigint NOT NULL,
    trade_date date NOT NULL,
    weight numeric(18,6),
    closing_price numeric(18,6),
    source_name text DEFAULT 'NSE_INDEX_EOD'::text NOT NULL,
    raw_row_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE nse_exchange_symbol.index_constituent_map OWNER TO rathore;

--
-- Name: index_master; Type: TABLE; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE TABLE nse_exchange_symbol.index_master (
    index_id bigint NOT NULL,
    index_name text NOT NULL,
    index_name_bhav_copy text,
    index_name_market_activity text,
    normalized_index_name text NOT NULL,
    index_name_alias_list jsonb DEFAULT '[]'::jsonb NOT NULL,
    index_code text,
    category_name text,
    is_sectoral boolean DEFAULT false NOT NULL,
    is_broad_market boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    metadata_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE nse_exchange_symbol.index_master OWNER TO rathore;

--
-- Name: index_master_index_id_seq; Type: SEQUENCE; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE nse_exchange_symbol.index_master_index_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nse_exchange_symbol.index_master_index_id_seq OWNER TO rathore;

--
-- Name: index_master_index_id_seq; Type: SEQUENCE OWNED BY; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE nse_exchange_symbol.index_master_index_id_seq OWNED BY nse_exchange_symbol.index_master.index_id;


--
-- Name: instrument_all_time_levels; Type: TABLE; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE TABLE nse_exchange_symbol.instrument_all_time_levels (
    instrument_id bigint NOT NULL,
    level_type character varying(10) NOT NULL,
    price numeric(20,4) NOT NULL,
    level_date timestamp without time zone NOT NULL,
    recorded_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE nse_exchange_symbol.instrument_all_time_levels OWNER TO rathore;

--
-- Name: instrument_chart_bootstrap; Type: TABLE; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE TABLE nse_exchange_symbol.instrument_chart_bootstrap (
    bootstrap_id bigint NOT NULL,
    instrument_id bigint NOT NULL,
    chart_data_required boolean DEFAULT false NOT NULL,
    chart_data_exists boolean DEFAULT false NOT NULL,
    chart_csv_detected boolean DEFAULT false NOT NULL,
    chart_csv_source_path text,
    chart_csv_last_detected_at timestamp without time zone,
    nse_daily_report_sources_json jsonb DEFAULT '[]'::jsonb CONSTRAINT instrument_chart_bootstrap_nse_daily_report_sources_js_not_null NOT NULL,
    preferred_nse_daily_report_source text,
    preferred_bootstrap_source text,
    bootstrap_source text,
    auto_detected_source text,
    auto_detected_sources_json jsonb DEFAULT '[]'::jsonb NOT NULL,
    auto_import_enabled boolean DEFAULT false NOT NULL,
    auto_import_mode text,
    last_auto_import_at timestamp without time zone,
    chart_timeframe_required text DEFAULT 'hour'::text NOT NULL,
    chart_timeframe_actual text,
    chart_timeframes_detected_json jsonb DEFAULT '[]'::jsonb CONSTRAINT instrument_chart_bootstrap_chart_timeframes_detected_j_not_null NOT NULL,
    chart_timeframes_available_json jsonb DEFAULT '[]'::jsonb CONSTRAINT instrument_chart_bootstrap_chart_timeframes_available__not_null NOT NULL,
    rebuild_required boolean DEFAULT false NOT NULL,
    rebuild_reason text,
    chart_data_status text DEFAULT 'SKIPPED'::text NOT NULL,
    bootstrap_status text DEFAULT 'NEW'::text NOT NULL,
    chart_from_date date,
    chart_to_date date,
    csv_from_date date,
    csv_to_date date,
    daily_report_from_date date,
    daily_report_to_date date,
    last_source_scan_at timestamp without time zone,
    last_bootstrap_started_at timestamp without time zone,
    last_bootstrap_completed_at timestamp without time zone,
    last_rebuild_at timestamp without time zone,
    last_error_at timestamp without time zone,
    last_error_message text,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bootstrap_completed_through_date date,
    reconcile_watermark_date date,
    last_reconcile_started_at timestamp without time zone,
    last_reconcile_completed_at timestamp without time zone,
    last_reconcile_status text,
    last_reconcile_error text,
    reconcile_status text,
    reconcile_error text,
    CONSTRAINT chk_nse_preferred_daily_report_source CHECK (((preferred_nse_daily_report_source IS NULL) OR (preferred_nse_daily_report_source = ANY (ARRAY['BHAV_COPY'::text, 'MARKET_ACTIVITY'::text]))))
);


ALTER TABLE nse_exchange_symbol.instrument_chart_bootstrap OWNER TO rathore;

--
-- Name: instrument_chart_bootstrap_bootstrap_id_seq; Type: SEQUENCE; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE nse_exchange_symbol.instrument_chart_bootstrap_bootstrap_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nse_exchange_symbol.instrument_chart_bootstrap_bootstrap_id_seq OWNER TO rathore;

--
-- Name: instrument_chart_bootstrap_bootstrap_id_seq; Type: SEQUENCE OWNED BY; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE nse_exchange_symbol.instrument_chart_bootstrap_bootstrap_id_seq OWNED BY nse_exchange_symbol.instrument_chart_bootstrap.bootstrap_id;


--
-- Name: instrument_master; Type: TABLE; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE TABLE nse_exchange_symbol.instrument_master (
    instrument_id bigint NOT NULL,
    instrument_key text NOT NULL,
    symbol text NOT NULL,
    trading_symbol text,
    instrument_type text NOT NULL,
    asset_class text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    tick_size numeric(18,8),
    lot_size integer,
    face_value numeric(18,4),
    currency_code text DEFAULT 'INR'::text NOT NULL,
    first_seen_date date,
    last_seen_date date,
    source_entity_type text,
    source_entity_id bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE nse_exchange_symbol.instrument_master OWNER TO rathore;

--
-- Name: instrument_master_equity; Type: TABLE; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE TABLE nse_exchange_symbol.instrument_master_equity (
    instrument_id bigint NOT NULL,
    company_name text,
    isin text,
    sector text,
    industry text,
    market_cap_bucket text,
    index_member_flag boolean DEFAULT false NOT NULL,
    token text,
    series text,
    code text,
    canonical_symbol text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE nse_exchange_symbol.instrument_master_equity OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE nse_exchange_symbol.instrument_master_instrument_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nse_exchange_symbol.instrument_master_instrument_id_seq OWNER TO rathore;

--
-- Name: instrument_master_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE nse_exchange_symbol.instrument_master_instrument_id_seq OWNED BY nse_exchange_symbol.instrument_master.instrument_id;


--
-- Name: phase0_run_audit; Type: TABLE; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE TABLE nse_exchange_symbol.phase0_run_audit (
    run_id bigint NOT NULL,
    step_code text NOT NULL,
    status text NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    rows_inserted integer DEFAULT 0 NOT NULL,
    rows_updated integer DEFAULT 0 NOT NULL,
    rows_rejected integer DEFAULT 0 NOT NULL,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    error_message text
);


ALTER TABLE nse_exchange_symbol.phase0_run_audit OWNER TO rathore;

--
-- Name: phase0_run_audit_run_id_seq; Type: SEQUENCE; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE SEQUENCE nse_exchange_symbol.phase0_run_audit_run_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nse_exchange_symbol.phase0_run_audit_run_id_seq OWNER TO rathore;

--
-- Name: phase0_run_audit_run_id_seq; Type: SEQUENCE OWNED BY; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER SEQUENCE nse_exchange_symbol.phase0_run_audit_run_id_seq OWNED BY nse_exchange_symbol.phase0_run_audit.run_id;


--
-- Name: raw_ticks_tick_id_seq; Type: SEQUENCE; Schema: nse_tick_data; Owner: rathore
--

CREATE SEQUENCE nse_tick_data.raw_ticks_tick_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nse_tick_data.raw_ticks_tick_id_seq OWNER TO rathore;

--
-- Name: raw_ticks; Type: TABLE; Schema: nse_tick_data; Owner: rathore
--

CREATE TABLE nse_tick_data.raw_ticks (
    tick_id bigint DEFAULT nextval('nse_tick_data.raw_ticks_tick_id_seq'::regclass) NOT NULL,
    provider text DEFAULT 'SHOONYA'::text NOT NULL,
    exchange text NOT NULL,
    asset_class text,
    symbol text NOT NULL,
    trading_symbol text,
    token text NOT NULL,
    event_type text,
    event_ts timestamp without time zone,
    ingest_ts timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_price numeric(18,6),
    last_qty numeric(18,6),
    volume numeric(18,6),
    open_price numeric(18,6),
    high_price numeric(18,6),
    low_price numeric(18,6),
    close_price numeric(18,6),
    avg_price numeric(18,6),
    open_interest numeric(18,6),
    raw_payload jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE nse_tick_data.raw_ticks OWNER TO rathore;

--
-- Name: realtime_5m_bar; Type: TABLE; Schema: nse_tick_data; Owner: rathore
--

CREATE TABLE nse_tick_data.realtime_5m_bar (
    provider text DEFAULT 'SHOONYA'::text NOT NULL,
    exchange text NOT NULL,
    asset_class text,
    symbol text NOT NULL,
    trading_symbol text,
    token text,
    bar_start_ts timestamp without time zone NOT NULL,
    bar_end_ts timestamp without time zone NOT NULL,
    open_price numeric(18,6) NOT NULL,
    high_price numeric(18,6) NOT NULL,
    low_price numeric(18,6) NOT NULL,
    close_price numeric(18,6) NOT NULL,
    volume numeric(18,6),
    tick_count integer DEFAULT 0 NOT NULL,
    status text DEFAULT 'LIVE_PARTIAL'::text NOT NULL,
    source_session_id text,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE nse_tick_data.realtime_5m_bar OWNER TO rathore;

--
-- Name: market_regime; Type: TABLE; Schema: signals_nse; Owner: rathore
--

CREATE TABLE signals_nse.market_regime (
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    exchange_code text NOT NULL,
    timeframe text NOT NULL,
    tf_id bigint NOT NULL,
    trade_date date,
    bar_start_ts timestamp without time zone,
    tsi_score double precision,
    market_phase text,
    market_state text,
    tf_alignment_score double precision,
    dominant_direction text,
    volatility_confirmation text,
    context_strength_score double precision,
    long_bias_component double precision,
    short_bias_component double precision,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE signals_nse.market_regime OWNER TO rathore;

--
-- Name: momentum_liquidity; Type: TABLE; Schema: signals_nse; Owner: rathore
--

CREATE TABLE signals_nse.momentum_liquidity (
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    exchange_code text NOT NULL,
    timeframe text NOT NULL,
    tf_id bigint NOT NULL,
    trade_date date,
    bar_start_ts timestamp without time zone,
    sms_score double precision,
    sms_expansion_score double precision,
    sms_strength_score double precision,
    sms_direction_score double precision,
    sms_state text,
    last_pivot_high double precision,
    last_pivot_low double precision,
    distance_to_high_pct double precision,
    distance_to_low_pct double precision,
    liquidity_proximity_score double precision,
    liquidity_sweep_flag smallint,
    liquidity_absorption_score double precision,
    liquidity_score double precision,
    liquidity_state text,
    order_flow_score double precision,
    order_flow_state text,
    accumulation_probability double precision,
    distribution_probability double precision,
    institutional_accumulation_score double precision,
    institutional_distribution_score double precision,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE signals_nse.momentum_liquidity OWNER TO rathore;

--
-- Name: structural_context; Type: TABLE; Schema: signals_nse; Owner: rathore
--

CREATE TABLE signals_nse.structural_context (
    instrument_id bigint NOT NULL,
    symbol character varying(128) NOT NULL,
    exchange_code character varying(16) NOT NULL,
    timeframe character varying(20) NOT NULL,
    tf_id bigint NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    trade_date date,
    structure_state character varying(32) NOT NULL,
    pivot_event character varying(32),
    nearest_pivot_tf_id bigint,
    nearest_pivot_type character varying(16),
    nearest_pivot_price numeric(18,6),
    pivot_distance_pct numeric(18,6),
    pivot_proximity_score numeric(18,6),
    liquidity_gravity_score numeric(18,6),
    liquidity_gravity_direction character varying(16),
    sma_trend_bias character varying(16),
    sma_in_range_count integer,
    sma20_trend_run integer,
    mmi_score numeric(18,6),
    support_score numeric(18,6),
    resistance_score numeric(18,6),
    confidence_score numeric(18,6),
    market_index_name text,
    market_context_role text,
    market_bias_score numeric(18,6),
    market_alignment_score numeric(18,6),
    sector_index_name text,
    sector_family text,
    sector_bias_score numeric(18,6),
    sector_alignment_score numeric(18,6),
    stock_vs_sector_rs_score numeric(18,6),
    stock_vs_market_rs_score numeric(18,6),
    context_lift_score numeric(18,6),
    context_penalty_score numeric(18,6),
    payload_json jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE signals_nse.structural_context OWNER TO rathore;

--
-- Name: symbol_signal; Type: TABLE; Schema: signals_nse; Owner: rathore
--

CREATE TABLE signals_nse.symbol_signal (
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    exchange_code text NOT NULL,
    timeframe text NOT NULL,
    tf_id bigint NOT NULL,
    trade_date date,
    bar_start_ts timestamp without time zone,
    tos_score double precision,
    trend_score double precision,
    memory_score double precision,
    liquidity_score_component double precision,
    volatility_score_component double precision,
    market_state_score double precision,
    signal_type text,
    signal_strength text,
    signal_reason text,
    trap_detected boolean DEFAULT false,
    trap_type text,
    trap_strength double precision,
    liquidity_sweep_detected boolean DEFAULT false,
    is_breakout_setup boolean DEFAULT false,
    is_pullback_setup boolean DEFAULT false,
    is_reversal_setup boolean DEFAULT false,
    is_accumulation_setup boolean DEFAULT false,
    cascade_probability double precision,
    market_alignment_score double precision,
    sector_alignment_score double precision,
    stock_vs_sector_rs_score double precision,
    stock_vs_market_rs_score double precision,
    context_alignment_score double precision,
    long_candidate_score double precision,
    short_candidate_score double precision,
    directional_bias text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE signals_nse.symbol_signal OWNER TO rathore;

--
-- Name: volatility_breakout; Type: TABLE; Schema: signals_nse; Owner: rathore
--

CREATE TABLE signals_nse.volatility_breakout (
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    exchange_code text NOT NULL,
    timeframe text NOT NULL,
    tf_id bigint NOT NULL,
    trade_date date,
    bar_start_ts timestamp without time zone,
    compression_score double precision,
    atr_ratio double precision,
    bb_width_percentile double precision,
    volatility_state text,
    pbps_score double precision,
    predicted_direction text,
    pivot_breakout boolean DEFAULT false,
    vacuum_score double precision,
    vacuum_direction text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE signals_nse.volatility_breakout OWNER TO rathore;

--
-- Name: broker_chart_api_raw; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.broker_chart_api_raw (
    cache_id bigint NOT NULL,
    instrument_id bigint NOT NULL,
    timeframe text NOT NULL,
    source_name text DEFAULT 'BROKER_API'::text NOT NULL,
    request_from_ts timestamp without time zone NOT NULL,
    request_to_ts timestamp without time zone NOT NULL,
    response_status text DEFAULT 'SUCCESS'::text NOT NULL,
    response_row_count integer DEFAULT 0 NOT NULL,
    raw_response_json jsonb DEFAULT '[]'::jsonb NOT NULL,
    source_request_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.broker_chart_api_raw OWNER TO rathore;

--
-- Name: broker_chart_api_raw_cache_id_seq; Type: SEQUENCE; Schema: staging; Owner: rathore
--

CREATE SEQUENCE staging.broker_chart_api_raw_cache_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE staging.broker_chart_api_raw_cache_id_seq OWNER TO rathore;

--
-- Name: broker_chart_api_raw_cache_id_seq; Type: SEQUENCE OWNED BY; Schema: staging; Owner: rathore
--

ALTER SEQUENCE staging.broker_chart_api_raw_cache_id_seq OWNED BY staging.broker_chart_api_raw.cache_id;


--
-- Name: chart_csv_candle_raw; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.chart_csv_candle_raw (
    instrument_id bigint NOT NULL,
    symbol text NOT NULL,
    timeframe text NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    bar_end_ts timestamp without time zone NOT NULL,
    trade_date date NOT NULL,
    open numeric(18,6) NOT NULL,
    high numeric(18,6) NOT NULL,
    low numeric(18,6) NOT NULL,
    close numeric(18,6) NOT NULL,
    volume numeric(20,4),
    open_interest numeric(20,4),
    source_file text NOT NULL,
    raw_row_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.chart_csv_candle_raw OWNER TO rathore;

--
-- Name: chart_csv_eod; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.chart_csv_eod (
    id bigint NOT NULL,
    instrument_id bigint,
    instrument_name text,
    timeframe text,
    trade_timestamp timestamp without time zone,
    trade_date date,
    bar_start_ts timestamp without time zone,
    bar_end_ts timestamp without time zone,
    open_price numeric(18,6),
    high_price numeric(18,6),
    low_price numeric(18,6),
    close_price numeric(18,6),
    volume numeric(20,4),
    source_file text,
    raw_row_json jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.chart_csv_eod OWNER TO rathore;

--
-- Name: chart_csv_eod_id_seq; Type: SEQUENCE; Schema: staging; Owner: rathore
--

CREATE SEQUENCE staging.chart_csv_eod_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE staging.chart_csv_eod_id_seq OWNER TO rathore;

--
-- Name: chart_csv_eod_id_seq; Type: SEQUENCE OWNED BY; Schema: staging; Owner: rathore
--

ALTER SEQUENCE staging.chart_csv_eod_id_seq OWNED BY staging.chart_csv_eod.id;


--
-- Name: chart_csv_file_audit; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.chart_csv_file_audit (
    instrument_id bigint NOT NULL,
    timeframe text NOT NULL,
    source_file text NOT NULL,
    source_hash text NOT NULL,
    status text NOT NULL,
    row_count integer DEFAULT 0 NOT NULL,
    rows_loaded integer DEFAULT 0 NOT NULL,
    error_message text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.chart_csv_file_audit OWNER TO rathore;

--
-- Name: market_candle_raw; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.market_candle_raw (
    id bigint NOT NULL,
    instrument_id integer NOT NULL,
    exchange_code character varying(10) NOT NULL,
    timeframe character varying(10) NOT NULL,
    bar_start_ts timestamp without time zone NOT NULL,
    bar_end_ts timestamp without time zone,
    trade_date date,
    candle_week date,
    session_bar_seq integer,
    open numeric(20,6),
    high numeric(20,6),
    low numeric(20,6),
    close numeric(20,6),
    volume numeric(20,6),
    open_interest numeric(20,6),
    source_name character varying(50) NOT NULL,
    source_priority integer NOT NULL,
    bar_status public.bar_status_enum,
    is_eod_reconciled boolean DEFAULT false,
    ingested_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE staging.market_candle_raw OWNER TO rathore;

--
-- Name: market_candle_raw_id_seq; Type: SEQUENCE; Schema: staging; Owner: rathore
--

CREATE SEQUENCE staging.market_candle_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE staging.market_candle_raw_id_seq OWNER TO rathore;

--
-- Name: market_candle_raw_id_seq; Type: SEQUENCE OWNED BY; Schema: staging; Owner: rathore
--

ALTER SEQUENCE staging.market_candle_raw_id_seq OWNED BY staging.market_candle_raw.id;


--
-- Name: nse_api_cache; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_api_cache (
    api_cache_id bigint NOT NULL,
    instrument_id bigint NOT NULL,
    timeframe text NOT NULL,
    source_name text DEFAULT 'SHOONYA'::text NOT NULL,
    request_from_ts timestamp without time zone,
    request_to_ts timestamp without time zone,
    response_status text,
    response_row_count integer DEFAULT 0 NOT NULL,
    raw_response_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    source_request_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_api_cache OWNER TO rathore;

--
-- Name: nse_api_cache_api_cache_id_seq; Type: SEQUENCE; Schema: staging; Owner: rathore
--

CREATE SEQUENCE staging.nse_api_cache_api_cache_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE staging.nse_api_cache_api_cache_id_seq OWNER TO rathore;

--
-- Name: nse_api_cache_api_cache_id_seq; Type: SEQUENCE OWNED BY; Schema: staging; Owner: rathore
--

ALTER SEQUENCE staging.nse_api_cache_api_cache_id_seq OWNED BY staging.nse_api_cache.api_cache_id;


--
-- Name: nse_bhavcopy_file_audit; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_bhavcopy_file_audit (
    audit_id bigint NOT NULL,
    file_name text NOT NULL,
    file_path text NOT NULL,
    trade_date date NOT NULL,
    status text NOT NULL,
    section_rows integer DEFAULT 0 NOT NULL,
    index_rows integer DEFAULT 0 NOT NULL,
    security_rows integer DEFAULT 0 NOT NULL,
    rejected_rows integer DEFAULT 0 NOT NULL,
    error_message text,
    processed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_bhavcopy_file_audit OWNER TO rathore;

--
-- Name: nse_bhavcopy_file_audit_audit_id_seq; Type: SEQUENCE; Schema: staging; Owner: rathore
--

CREATE SEQUENCE staging.nse_bhavcopy_file_audit_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE staging.nse_bhavcopy_file_audit_audit_id_seq OWNER TO rathore;

--
-- Name: nse_bhavcopy_file_audit_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: staging; Owner: rathore
--

ALTER SEQUENCE staging.nse_bhavcopy_file_audit_audit_id_seq OWNED BY staging.nse_bhavcopy_file_audit.audit_id;


--
-- Name: nse_bhavcopy_index_eod; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_bhavcopy_index_eod (
    trade_date date NOT NULL,
    index_name text NOT NULL,
    open_price numeric(18,4),
    high_price numeric(18,4),
    low_price numeric(18,4),
    close_price numeric(18,4),
    points_change numeric(18,4),
    pct_change numeric(10,4),
    volume numeric(20,2),
    turnover_cr numeric(20,4),
    raw_row jsonb DEFAULT '{}'::jsonb NOT NULL,
    source_file text,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_bhavcopy_index_eod OWNER TO rathore;

--
-- Name: nse_bhavcopy_section; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_bhavcopy_section (
    trade_date date NOT NULL,
    file_name text NOT NULL,
    row_number integer NOT NULL,
    raw_line text NOT NULL,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_bhavcopy_section OWNER TO rathore;

--
-- Name: nse_bhavcopy_security_eod; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_bhavcopy_security_eod (
    trade_date date NOT NULL,
    symbol text NOT NULL,
    series text NOT NULL,
    instrument_id bigint,
    open_price numeric(18,4),
    high_price numeric(18,4),
    low_price numeric(18,4),
    close_price numeric(18,4),
    prev_close numeric(18,4),
    tottrdqty numeric(20,2),
    tottrdval_lakh numeric(20,4),
    isin text,
    raw_row jsonb DEFAULT '{}'::jsonb NOT NULL,
    source_file text,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_bhavcopy_security_eod OWNER TO rathore;

--
-- Name: nse_eod_download_audit; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_eod_download_audit (
    audit_id bigint NOT NULL,
    trade_date date NOT NULL,
    report_type text NOT NULL,
    source_url text,
    source_file text,
    row_count integer DEFAULT 0 NOT NULL,
    status text NOT NULL,
    note text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_eod_download_audit OWNER TO rathore;

--
-- Name: nse_eod_download_audit_audit_id_seq; Type: SEQUENCE; Schema: staging; Owner: rathore
--

CREATE SEQUENCE staging.nse_eod_download_audit_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE staging.nse_eod_download_audit_audit_id_seq OWNER TO rathore;

--
-- Name: nse_eod_download_audit_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: staging; Owner: rathore
--

ALTER SEQUENCE staging.nse_eod_download_audit_audit_id_seq OWNED BY staging.nse_eod_download_audit.audit_id;


--
-- Name: nse_eod_equity; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_eod_equity (
    trade_date date NOT NULL,
    symbol text NOT NULL,
    series text,
    open_price numeric(18,6),
    high_price numeric(18,6),
    low_price numeric(18,6),
    close_price numeric(18,6),
    prev_close numeric(18,6),
    volume numeric(20,2),
    turnover_rs_cr numeric(20,2),
    deliverable_qty numeric(20,2),
    delivery_pct numeric(10,4),
    source_file text,
    raw_row jsonb DEFAULT '{}'::jsonb NOT NULL,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_eod_equity OWNER TO rathore;

--
-- Name: nse_eod_index; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_eod_index (
    trade_date date NOT NULL,
    index_name text NOT NULL,
    open_price numeric(18,6),
    high_price numeric(18,6),
    low_price numeric(18,6),
    close_price numeric(18,6),
    prev_close numeric(18,6),
    pe_ratio numeric(18,6),
    pb_ratio numeric(18,6),
    div_yield numeric(18,6),
    volume numeric(20,2),
    turnover_rs_cr numeric(20,2),
    source_file text,
    raw_row jsonb DEFAULT '{}'::jsonb NOT NULL,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_eod_index OWNER TO rathore;

--
-- Name: nse_hl_daily_levels; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_hl_daily_levels (
    trade_date date NOT NULL,
    security_name text NOT NULL,
    new_value numeric(18,6),
    previous_value numeric(18,6),
    new_status text NOT NULL,
    source_file text NOT NULL,
    raw_row_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_hl_daily_levels OWNER TO rathore;

--
-- Name: nse_hl_file_audit; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_hl_file_audit (
    trade_date date NOT NULL,
    source_file text NOT NULL,
    source_hash text NOT NULL,
    status text NOT NULL,
    row_count integer DEFAULT 0 NOT NULL,
    rows_loaded integer DEFAULT 0 NOT NULL,
    error_message text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_hl_file_audit OWNER TO rathore;

--
-- Name: nse_index_constituent_download_audit; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_index_constituent_download_audit (
    trade_date date NOT NULL,
    index_name text NOT NULL,
    status text NOT NULL,
    source_url text,
    source_file text,
    row_count integer DEFAULT 0 NOT NULL,
    note text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_index_constituent_download_audit OWNER TO rathore;

--
-- Name: nse_index_constituent_eod; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_index_constituent_eod (
    trade_date date NOT NULL,
    symbol text NOT NULL,
    index_names_csv text,
    source_files_csv text,
    open_price numeric(18,2),
    high_price numeric(18,2),
    low_price numeric(18,2),
    close_price numeric(18,2),
    ltp_close numeric(18,2),
    volume numeric(20,2),
    raw_row_json jsonb,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_index_constituent_eod OWNER TO rathore;

--
-- Name: nse_index_eod_run_tracker; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_index_eod_run_tracker (
    trade_date date NOT NULL,
    run_type text NOT NULL,
    status text NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    indices_discovered integer DEFAULT 0 NOT NULL,
    indices_downloaded integer DEFAULT 0 NOT NULL,
    rows_staged integer DEFAULT 0 NOT NULL,
    rows_built integer DEFAULT 0 NOT NULL,
    last_error_message text,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_index_eod_run_tracker OWNER TO rathore;

--
-- Name: nse_market_activity_file_audit; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_market_activity_file_audit (
    trade_date date NOT NULL,
    file_name text NOT NULL,
    file_hash text,
    status text NOT NULL,
    rows_processed integer DEFAULT 0 NOT NULL,
    rows_inserted integer DEFAULT 0 NOT NULL,
    error text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_market_activity_file_audit OWNER TO rathore;

--
-- Name: nse_market_activity_index_eod; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_market_activity_index_eod (
    trade_date date NOT NULL,
    index_name text NOT NULL,
    raw_index_name text,
    previous_close numeric(18,6),
    open_price numeric(18,6),
    high_price numeric(18,6),
    low_price numeric(18,6),
    close_price numeric(18,6),
    gain_loss numeric(18,6),
    source_file text NOT NULL,
    raw_row_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_market_activity_index_eod OWNER TO rathore;

--
-- Name: nse_market_activity_market_report; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_market_activity_market_report (
    trade_date date NOT NULL,
    source_file text NOT NULL,
    summary_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    gain_loss_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    indices_snapshot_json jsonb DEFAULT '[]'::jsonb CONSTRAINT nse_market_activity_market_repor_indices_snapshot_json_not_null NOT NULL,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    footer_raw_json jsonb DEFAULT '[]'::jsonb NOT NULL
);


ALTER TABLE staging.nse_market_activity_market_report OWNER TO rathore;

--
-- Name: nse_market_activity_report; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_market_activity_report (
    trade_date date NOT NULL,
    source_file text NOT NULL,
    report_meta_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    raw_header_lines_json jsonb DEFAULT '[]'::jsonb NOT NULL,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_market_activity_report OWNER TO rathore;

--
-- Name: nse_pd_file_audit; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_pd_file_audit (
    trade_date date NOT NULL,
    source_file text NOT NULL,
    source_hash text NOT NULL,
    status text NOT NULL,
    row_count integer DEFAULT 0 NOT NULL,
    rows_loaded integer DEFAULT 0 NOT NULL,
    error_message text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_pd_file_audit OWNER TO rathore;

--
-- Name: nse_pd_index_eod; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_pd_index_eod (
    trade_date date NOT NULL,
    market_flag text,
    series text,
    symbol text,
    security_name text NOT NULL,
    prev_close numeric(18,6),
    open_price numeric(18,6),
    high_price numeric(18,6),
    low_price numeric(18,6),
    close_price numeric(18,6),
    net_trdval numeric(20,2),
    net_trdqty numeric(20,2),
    ind_sec text,
    corp_ind text,
    trades numeric(20,2),
    hi_52_wk numeric(18,6),
    lo_52_wk numeric(18,6),
    source_file text NOT NULL,
    raw_row_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    pd_stage_id bigint NOT NULL
);


ALTER TABLE staging.nse_pd_index_eod OWNER TO rathore;

--
-- Name: nse_pd_index_eod_pd_stage_id_seq; Type: SEQUENCE; Schema: staging; Owner: rathore
--

CREATE SEQUENCE staging.nse_pd_index_eod_pd_stage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE staging.nse_pd_index_eod_pd_stage_id_seq OWNER TO rathore;

--
-- Name: nse_pd_index_eod_pd_stage_id_seq; Type: SEQUENCE OWNED BY; Schema: staging; Owner: rathore
--

ALTER SEQUENCE staging.nse_pd_index_eod_pd_stage_id_seq OWNED BY staging.nse_pd_index_eod.pd_stage_id;


--
-- Name: nse_pr_file_audit; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_pr_file_audit (
    trade_date date NOT NULL,
    source_file text NOT NULL,
    source_hash text NOT NULL,
    status text NOT NULL,
    row_count integer DEFAULT 0 NOT NULL,
    rows_loaded integer DEFAULT 0 NOT NULL,
    error_message text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_pr_file_audit OWNER TO rathore;

--
-- Name: nse_pr_index_eod; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.nse_pr_index_eod (
    trade_date date NOT NULL,
    market_flag text,
    security_name text NOT NULL,
    prev_close numeric(18,6),
    open_price numeric(18,6),
    high_price numeric(18,6),
    low_price numeric(18,6),
    close_price numeric(18,6),
    net_trdval numeric(20,2),
    net_trdqty numeric(20,2),
    ind_sec text,
    corp_ind text,
    trades numeric(20,2),
    hi_52_wk numeric(18,6),
    lo_52_wk numeric(18,6),
    source_file text NOT NULL,
    raw_row_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    loaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.nse_pr_index_eod OWNER TO rathore;

--
-- Name: phase_a_file_checkpoint; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.phase_a_file_checkpoint (
    source_type text NOT NULL,
    file_name text NOT NULL,
    file_hash text,
    status text NOT NULL,
    rows_processed integer DEFAULT 0 NOT NULL,
    rows_inserted integer DEFAULT 0 NOT NULL,
    error text,
    first_seen_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_processed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.phase_a_file_checkpoint OWNER TO rathore;

--
-- Name: phase_a_run_audit; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.phase_a_run_audit (
    run_id bigint NOT NULL,
    pipeline_name text DEFAULT 'PHASE_A'::text NOT NULL,
    status text NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    triggered_by text,
    mode text,
    bootstrap_start_date date,
    error_message text,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE staging.phase_a_run_audit OWNER TO rathore;

--
-- Name: phase_a_run_audit_run_id_seq; Type: SEQUENCE; Schema: staging; Owner: rathore
--

CREATE SEQUENCE staging.phase_a_run_audit_run_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE staging.phase_a_run_audit_run_id_seq OWNER TO rathore;

--
-- Name: phase_a_run_audit_run_id_seq; Type: SEQUENCE OWNED BY; Schema: staging; Owner: rathore
--

ALTER SEQUENCE staging.phase_a_run_audit_run_id_seq OWNED BY staging.phase_a_run_audit.run_id;


--
-- Name: phase_a_run_tracker; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.phase_a_run_tracker (
    run_id bigint NOT NULL,
    run_mode text NOT NULL,
    pipeline_name text DEFAULT 'phase_a'::text NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    status text DEFAULT 'RUNNING'::text NOT NULL,
    bootstrap_start_date date,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE staging.phase_a_run_tracker OWNER TO rathore;

--
-- Name: phase_a_run_tracker_run_id_seq; Type: SEQUENCE; Schema: staging; Owner: rathore
--

CREATE SEQUENCE staging.phase_a_run_tracker_run_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE staging.phase_a_run_tracker_run_id_seq OWNER TO rathore;

--
-- Name: phase_a_run_tracker_run_id_seq; Type: SEQUENCE OWNED BY; Schema: staging; Owner: rathore
--

ALTER SEQUENCE staging.phase_a_run_tracker_run_id_seq OWNED BY staging.phase_a_run_tracker.run_id;


--
-- Name: phase_a_step_run_audit; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.phase_a_step_run_audit (
    step_run_id bigint NOT NULL,
    run_id bigint NOT NULL,
    step_code text NOT NULL,
    substep_code text,
    status text NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    completed_at timestamp without time zone,
    rows_processed integer DEFAULT 0 NOT NULL,
    rows_inserted integer DEFAULT 0 NOT NULL,
    rows_updated integer DEFAULT 0 NOT NULL,
    rows_rejected integer DEFAULT 0 NOT NULL,
    error_message text,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE staging.phase_a_step_run_audit OWNER TO rathore;

--
-- Name: phase_a_step_run_audit_step_run_id_seq; Type: SEQUENCE; Schema: staging; Owner: rathore
--

CREATE SEQUENCE staging.phase_a_step_run_audit_step_run_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE staging.phase_a_step_run_audit_step_run_id_seq OWNER TO rathore;

--
-- Name: phase_a_step_run_audit_step_run_id_seq; Type: SEQUENCE OWNED BY; Schema: staging; Owner: rathore
--

ALTER SEQUENCE staging.phase_a_step_run_audit_step_run_id_seq OWNED BY staging.phase_a_step_run_audit.step_run_id;


--
-- Name: phase_a_substep_tracker; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.phase_a_substep_tracker (
    pipeline_name text DEFAULT 'phase_a'::text NOT NULL,
    step_name text NOT NULL,
    substep_name text NOT NULL,
    status text NOT NULL,
    last_success_at timestamp without time zone,
    last_failure_at timestamp without time zone,
    last_run_id bigint,
    rows_processed integer DEFAULT 0 NOT NULL,
    rows_inserted integer DEFAULT 0 NOT NULL,
    error_text text,
    watermark_date date,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.phase_a_substep_tracker OWNER TO rathore;

--
-- Name: rest_unavailable_symbols; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.rest_unavailable_symbols (
    exchange_code character varying(10) NOT NULL,
    symbol character varying(50) NOT NULL,
    instrument_id integer,
    marked_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    reason character varying(255)
);


ALTER TABLE staging.rest_unavailable_symbols OWNER TO rathore;

--
-- Name: step03_candidate_integrity_audit; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.step03_candidate_integrity_audit (
    run_id bigint NOT NULL,
    instrument_id bigint NOT NULL,
    instrument_type text,
    timeframe text NOT NULL,
    market_min_trade_date date,
    market_max_trade_date date,
    bootstrap_chart_from_date date,
    bootstrap_chart_to_date date,
    bootstrap_completed_through_date date,
    reconcile_watermark_date date,
    expected_from_date date,
    expected_to_date date,
    available_timeframes_json jsonb DEFAULT '[]'::jsonb CONSTRAINT step03_candidate_integrity_a_available_timeframes_json_not_null NOT NULL,
    integrity_flags_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    gap_days integer DEFAULT 0 NOT NULL,
    candidate_required boolean DEFAULT false NOT NULL,
    candidate_reason text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE staging.step03_candidate_integrity_audit OWNER TO rathore;

--
-- Name: step03_reconcile_candidate; Type: TABLE; Schema: staging; Owner: rathore
--

CREATE TABLE staging.step03_reconcile_candidate (
    candidate_id bigint NOT NULL,
    run_id text NOT NULL,
    prepared_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    instrument_id bigint NOT NULL,
    exchange_code text NOT NULL,
    symbol text NOT NULL,
    requested_trade_date date NOT NULL,
    target_timeframes_json jsonb DEFAULT '[]'::jsonb NOT NULL,
    requested_intraday_timeframe text,
    requested_day_reconcile boolean DEFAULT false NOT NULL,
    requested_week_rebuild boolean DEFAULT false NOT NULL,
    latest_hour_bar_start_ts timestamp without time zone,
    latest_day_bar_start_ts timestamp without time zone,
    latest_week_bar_start_ts timestamp without time zone,
    missing_intraday_hours integer DEFAULT 0 NOT NULL,
    missing_day_bars integer DEFAULT 0 NOT NULL,
    missing_week_bars integer DEFAULT 0 NOT NULL,
    intraday_reconcile_from_date date,
    intraday_reconcile_to_date date,
    day_reconcile_from_date date,
    day_reconcile_to_date date,
    candidate_status text DEFAULT 'PENDING'::text NOT NULL,
    candidate_flags_json jsonb DEFAULT '{}'::jsonb NOT NULL,
    notes_json jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE staging.step03_reconcile_candidate OWNER TO rathore;

--
-- Name: step03_reconcile_candidate_candidate_id_seq; Type: SEQUENCE; Schema: staging; Owner: rathore
--

CREATE SEQUENCE staging.step03_reconcile_candidate_candidate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE staging.step03_reconcile_candidate_candidate_id_seq OWNER TO rathore;

--
-- Name: step03_reconcile_candidate_candidate_id_seq; Type: SEQUENCE OWNED BY; Schema: staging; Owner: rathore
--

ALTER SEQUENCE staging.step03_reconcile_candidate_candidate_id_seq OWNED BY staging.step03_reconcile_candidate.candidate_id;


--
-- Name: instrument_master instrument_id; Type: DEFAULT; Schema: bfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bfo_exchange_symbol.instrument_master ALTER COLUMN instrument_id SET DEFAULT nextval('bfo_exchange_symbol.instrument_master_instrument_id_seq'::regclass);


--
-- Name: phase0_run_audit run_id; Type: DEFAULT; Schema: bfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bfo_exchange_symbol.phase0_run_audit ALTER COLUMN run_id SET DEFAULT nextval('bfo_exchange_symbol.phase0_run_audit_run_id_seq'::regclass);


--
-- Name: instrument_chart_bootstrap bootstrap_id; Type: DEFAULT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.instrument_chart_bootstrap ALTER COLUMN bootstrap_id SET DEFAULT nextval('bse_exchange_symbol.instrument_chart_bootstrap_bootstrap_id_seq'::regclass);


--
-- Name: instrument_master instrument_id; Type: DEFAULT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.instrument_master ALTER COLUMN instrument_id SET DEFAULT nextval('bse_exchange_symbol.instrument_master_instrument_id_seq'::regclass);


--
-- Name: phase0_run_audit run_id; Type: DEFAULT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.phase0_run_audit ALTER COLUMN run_id SET DEFAULT nextval('bse_exchange_symbol.phase0_run_audit_run_id_seq'::regclass);


--
-- Name: instrument_master instrument_id; Type: DEFAULT; Schema: cds_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY cds_exchange_symbol.instrument_master ALTER COLUMN instrument_id SET DEFAULT nextval('cds_exchange_symbol.instrument_master_instrument_id_seq'::regclass);


--
-- Name: phase0_run_audit run_id; Type: DEFAULT; Schema: cds_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY cds_exchange_symbol.phase0_run_audit ALTER COLUMN run_id SET DEFAULT nextval('cds_exchange_symbol.phase0_run_audit_run_id_seq'::regclass);


--
-- Name: pivot_metrics id; Type: DEFAULT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.pivot_metrics ALTER COLUMN id SET DEFAULT nextval('core_app_mcx.pivot_metrics_id_seq'::regclass);


--
-- Name: trend_pivot_metrics id; Type: DEFAULT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.trend_pivot_metrics ALTER COLUMN id SET DEFAULT nextval('core_app_mcx.trend_pivot_metrics_id_seq'::regclass);


--
-- Name: pivot_metrics id; Type: DEFAULT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.pivot_metrics ALTER COLUMN id SET DEFAULT nextval('core_app_nfo.pivot_metrics_id_seq'::regclass);


--
-- Name: trend_pivot_metrics id; Type: DEFAULT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.trend_pivot_metrics ALTER COLUMN id SET DEFAULT nextval('core_app_nfo.trend_pivot_metrics_id_seq'::regclass);


--
-- Name: pivot_metrics id; Type: DEFAULT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.pivot_metrics ALTER COLUMN id SET DEFAULT nextval('core_app_nse.pivot_metrics_id_seq'::regclass);


--
-- Name: trend_pivot_metrics id; Type: DEFAULT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.trend_pivot_metrics ALTER COLUMN id SET DEFAULT nextval('core_app_nse.trend_pivot_metrics_id_seq'::regclass);


--
-- Name: instrument_master instrument_id; Type: DEFAULT; Schema: exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY exchange_symbol.instrument_master ALTER COLUMN instrument_id SET DEFAULT nextval('exchange_symbol.instrument_master_instrument_id_seq'::regclass);


--
-- Name: eod_reconciliation_log reconciliation_id; Type: DEFAULT; Schema: market_mcx; Owner: rathore
--

ALTER TABLE ONLY market_mcx.eod_reconciliation_log ALTER COLUMN reconciliation_id SET DEFAULT nextval('market_mcx.eod_reconciliation_log_reconciliation_id_seq1'::regclass);


--
-- Name: eod_reconciliation_log reconciliation_id; Type: DEFAULT; Schema: market_nfo; Owner: rathore
--

ALTER TABLE ONLY market_nfo.eod_reconciliation_log ALTER COLUMN reconciliation_id SET DEFAULT nextval('market_nfo.eod_reconciliation_log_reconciliation_id_seq1'::regclass);


--
-- Name: eod_reconciliation_log reconciliation_id; Type: DEFAULT; Schema: market_nse; Owner: rathore
--

ALTER TABLE ONLY market_nse.eod_reconciliation_log ALTER COLUMN reconciliation_id SET DEFAULT nextval('market_nse.eod_reconciliation_log_reconciliation_id_seq1'::regclass);


--
-- Name: instrument_master instrument_id; Type: DEFAULT; Schema: mcx_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY mcx_exchange_symbol.instrument_master ALTER COLUMN instrument_id SET DEFAULT nextval('mcx_exchange_symbol.instrument_master_instrument_id_seq'::regclass);


--
-- Name: phase0_run_audit run_id; Type: DEFAULT; Schema: mcx_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY mcx_exchange_symbol.phase0_run_audit ALTER COLUMN run_id SET DEFAULT nextval('mcx_exchange_symbol.phase0_run_audit_run_id_seq'::regclass);


--
-- Name: csv_ingestion_audit id; Type: DEFAULT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.csv_ingestion_audit ALTER COLUMN id SET DEFAULT nextval('meta_data.csv_ingestion_audit_id_seq'::regclass);


--
-- Name: engine_error_log error_id; Type: DEFAULT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.engine_error_log ALTER COLUMN error_id SET DEFAULT nextval('meta_data.engine_error_log_error_id_seq'::regclass);


--
-- Name: engine_run_tracker tracker_id; Type: DEFAULT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.engine_run_tracker ALTER COLUMN tracker_id SET DEFAULT nextval('meta_data.engine_run_tracker_tracker_id_seq'::regclass);


--
-- Name: pipeline_run_metrics run_id; Type: DEFAULT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.pipeline_run_metrics ALTER COLUMN run_id SET DEFAULT nextval('meta_data.pipeline_run_metrics_run_id_seq'::regclass);


--
-- Name: shoonya_api_call_audit shoonya_api_call_audit_id; Type: DEFAULT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.shoonya_api_call_audit ALTER COLUMN shoonya_api_call_audit_id SET DEFAULT nextval('meta_data.shoonya_api_call_audit_shoonya_api_call_audit_id_seq'::regclass);


--
-- Name: csv_ingestion_audit id; Type: DEFAULT; Schema: metadata; Owner: rathore
--

ALTER TABLE ONLY metadata.csv_ingestion_audit ALTER COLUMN id SET DEFAULT nextval('metadata.csv_ingestion_audit_id_seq'::regclass);


--
-- Name: instrument_bootstrap_audit instrument_bootstrap_audit_id; Type: DEFAULT; Schema: metadata; Owner: rathore
--

ALTER TABLE ONLY metadata.instrument_bootstrap_audit ALTER COLUMN instrument_bootstrap_audit_id SET DEFAULT nextval('metadata.instrument_bootstrap_audit_instrument_bootstrap_audit_id_seq'::regclass);


--
-- Name: pipeline_step_run_audit run_audit_id; Type: DEFAULT; Schema: metadata; Owner: rathore
--

ALTER TABLE ONLY metadata.pipeline_step_run_audit ALTER COLUMN run_audit_id SET DEFAULT nextval('metadata.pipeline_step_run_audit_run_audit_id_seq'::regclass);


--
-- Name: instrument_master instrument_id; Type: DEFAULT; Schema: nfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nfo_exchange_symbol.instrument_master ALTER COLUMN instrument_id SET DEFAULT nextval('nfo_exchange_symbol.instrument_master_instrument_id_seq'::regclass);


--
-- Name: phase0_run_audit run_id; Type: DEFAULT; Schema: nfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nfo_exchange_symbol.phase0_run_audit ALTER COLUMN run_id SET DEFAULT nextval('nfo_exchange_symbol.phase0_run_audit_run_id_seq'::regclass);


--
-- Name: index_master index_id; Type: DEFAULT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.index_master ALTER COLUMN index_id SET DEFAULT nextval('nse_exchange_symbol.index_master_index_id_seq'::regclass);


--
-- Name: instrument_chart_bootstrap bootstrap_id; Type: DEFAULT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.instrument_chart_bootstrap ALTER COLUMN bootstrap_id SET DEFAULT nextval('nse_exchange_symbol.instrument_chart_bootstrap_bootstrap_id_seq'::regclass);


--
-- Name: instrument_master instrument_id; Type: DEFAULT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.instrument_master ALTER COLUMN instrument_id SET DEFAULT nextval('nse_exchange_symbol.instrument_master_instrument_id_seq'::regclass);


--
-- Name: phase0_run_audit run_id; Type: DEFAULT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.phase0_run_audit ALTER COLUMN run_id SET DEFAULT nextval('nse_exchange_symbol.phase0_run_audit_run_id_seq'::regclass);


--
-- Name: broker_chart_api_raw cache_id; Type: DEFAULT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.broker_chart_api_raw ALTER COLUMN cache_id SET DEFAULT nextval('staging.broker_chart_api_raw_cache_id_seq'::regclass);


--
-- Name: chart_csv_eod id; Type: DEFAULT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.chart_csv_eod ALTER COLUMN id SET DEFAULT nextval('staging.chart_csv_eod_id_seq'::regclass);


--
-- Name: market_candle_raw id; Type: DEFAULT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.market_candle_raw ALTER COLUMN id SET DEFAULT nextval('staging.market_candle_raw_id_seq'::regclass);


--
-- Name: nse_api_cache api_cache_id; Type: DEFAULT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_api_cache ALTER COLUMN api_cache_id SET DEFAULT nextval('staging.nse_api_cache_api_cache_id_seq'::regclass);


--
-- Name: nse_bhavcopy_file_audit audit_id; Type: DEFAULT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_bhavcopy_file_audit ALTER COLUMN audit_id SET DEFAULT nextval('staging.nse_bhavcopy_file_audit_audit_id_seq'::regclass);


--
-- Name: nse_eod_download_audit audit_id; Type: DEFAULT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_eod_download_audit ALTER COLUMN audit_id SET DEFAULT nextval('staging.nse_eod_download_audit_audit_id_seq'::regclass);


--
-- Name: nse_pd_index_eod pd_stage_id; Type: DEFAULT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_pd_index_eod ALTER COLUMN pd_stage_id SET DEFAULT nextval('staging.nse_pd_index_eod_pd_stage_id_seq'::regclass);


--
-- Name: phase_a_run_audit run_id; Type: DEFAULT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.phase_a_run_audit ALTER COLUMN run_id SET DEFAULT nextval('staging.phase_a_run_audit_run_id_seq'::regclass);


--
-- Name: phase_a_run_tracker run_id; Type: DEFAULT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.phase_a_run_tracker ALTER COLUMN run_id SET DEFAULT nextval('staging.phase_a_run_tracker_run_id_seq'::regclass);


--
-- Name: phase_a_step_run_audit step_run_id; Type: DEFAULT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.phase_a_step_run_audit ALTER COLUMN step_run_id SET DEFAULT nextval('staging.phase_a_step_run_audit_step_run_id_seq'::regclass);


--
-- Name: step03_reconcile_candidate candidate_id; Type: DEFAULT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.step03_reconcile_candidate ALTER COLUMN candidate_id SET DEFAULT nextval('staging.step03_reconcile_candidate_candidate_id_seq'::regclass);


--
-- Name: instrument_master_derivative instrument_master_derivative_pkey; Type: CONSTRAINT; Schema: bfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bfo_exchange_symbol.instrument_master_derivative
    ADD CONSTRAINT instrument_master_derivative_pkey PRIMARY KEY (instrument_id);


--
-- Name: instrument_master instrument_master_pkey; Type: CONSTRAINT; Schema: bfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bfo_exchange_symbol.instrument_master
    ADD CONSTRAINT instrument_master_pkey PRIMARY KEY (instrument_id);


--
-- Name: phase0_run_audit phase0_run_audit_pkey; Type: CONSTRAINT; Schema: bfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bfo_exchange_symbol.phase0_run_audit
    ADD CONSTRAINT phase0_run_audit_pkey PRIMARY KEY (run_id);


--
-- Name: instrument_master uq_bfo_instrument_master_instrument_key; Type: CONSTRAINT; Schema: bfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bfo_exchange_symbol.instrument_master
    ADD CONSTRAINT uq_bfo_instrument_master_instrument_key UNIQUE (instrument_key);


--
-- Name: instrument_all_time_levels bse_instrument_all_time_levels_pkey; Type: CONSTRAINT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.instrument_all_time_levels
    ADD CONSTRAINT bse_instrument_all_time_levels_pkey PRIMARY KEY (instrument_id, level_type);


--
-- Name: instrument_chart_bootstrap instrument_chart_bootstrap_instrument_id_key; Type: CONSTRAINT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.instrument_chart_bootstrap
    ADD CONSTRAINT instrument_chart_bootstrap_instrument_id_key UNIQUE (instrument_id);


--
-- Name: instrument_chart_bootstrap instrument_chart_bootstrap_pkey; Type: CONSTRAINT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.instrument_chart_bootstrap
    ADD CONSTRAINT instrument_chart_bootstrap_pkey PRIMARY KEY (bootstrap_id);


--
-- Name: instrument_master_equity instrument_master_equity_pkey; Type: CONSTRAINT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.instrument_master_equity
    ADD CONSTRAINT instrument_master_equity_pkey PRIMARY KEY (instrument_id);


--
-- Name: instrument_master instrument_master_pkey; Type: CONSTRAINT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.instrument_master
    ADD CONSTRAINT instrument_master_pkey PRIMARY KEY (instrument_id);


--
-- Name: phase0_run_audit phase0_run_audit_pkey; Type: CONSTRAINT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.phase0_run_audit
    ADD CONSTRAINT phase0_run_audit_pkey PRIMARY KEY (run_id);


--
-- Name: instrument_master uq_bse_instrument_master_instrument_key; Type: CONSTRAINT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.instrument_master
    ADD CONSTRAINT uq_bse_instrument_master_instrument_key UNIQUE (instrument_key);


--
-- Name: instrument_master_derivative instrument_master_derivative_pkey; Type: CONSTRAINT; Schema: cds_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY cds_exchange_symbol.instrument_master_derivative
    ADD CONSTRAINT instrument_master_derivative_pkey PRIMARY KEY (instrument_id);


--
-- Name: instrument_master instrument_master_instrument_key_key; Type: CONSTRAINT; Schema: cds_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY cds_exchange_symbol.instrument_master
    ADD CONSTRAINT instrument_master_instrument_key_key UNIQUE (instrument_key);


--
-- Name: instrument_master instrument_master_pkey; Type: CONSTRAINT; Schema: cds_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY cds_exchange_symbol.instrument_master
    ADD CONSTRAINT instrument_master_pkey PRIMARY KEY (instrument_id);


--
-- Name: phase0_run_audit phase0_run_audit_pkey; Type: CONSTRAINT; Schema: cds_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY cds_exchange_symbol.phase0_run_audit
    ADD CONSTRAINT phase0_run_audit_pkey PRIMARY KEY (run_id);


--
-- Name: candle_matrix_metrics candle_matrix_metrics_pkey; Type: CONSTRAINT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.candle_matrix_metrics
    ADD CONSTRAINT candle_matrix_metrics_pkey PRIMARY KEY (symbol, timeframe, tf_id);


--
-- Name: candle_nbar_state candle_nbar_state_pkey; Type: CONSTRAINT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.candle_nbar_state
    ADD CONSTRAINT candle_nbar_state_pkey PRIMARY KEY (symbol, timeframe, tf_id);


--
-- Name: pipeline_step_tracker pipeline_step_tracker_pkey; Type: CONSTRAINT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.pipeline_step_tracker
    ADD CONSTRAINT pipeline_step_tracker_pkey PRIMARY KEY (tracker_name, instrument_id, timeframe);


--
-- Name: pivot_candle_pivots pivot_candle_pivots_pkey; Type: CONSTRAINT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.pivot_candle_pivots
    ADD CONSTRAINT pivot_candle_pivots_pkey PRIMARY KEY (symbol, timeframe, start_at);


--
-- Name: pivot_candles pivot_candles_pkey; Type: CONSTRAINT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.pivot_candles
    ADD CONSTRAINT pivot_candles_pkey PRIMARY KEY (symbol, timeframe, opening_pivot_tf_id);


--
-- Name: pivot_metrics pivot_metrics_pkey; Type: CONSTRAINT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.pivot_metrics
    ADD CONSTRAINT pivot_metrics_pkey PRIMARY KEY (id);


--
-- Name: fractal_trend_pivots_metrics pk_fractal_trend_pivots_metrics_mcx; Type: CONSTRAINT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.fractal_trend_pivots_metrics
    ADD CONSTRAINT pk_fractal_trend_pivots_metrics_mcx PRIMARY KEY (symbol, tf_id, timeframe);


--
-- Name: n_bar_pivot_metrics pk_n_bar_pivot_metrics_mcx; Type: CONSTRAINT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.n_bar_pivot_metrics
    ADD CONSTRAINT pk_n_bar_pivot_metrics_mcx PRIMARY KEY (symbol, tf_id, timeframe);


--
-- Name: n_bar_support_resistance_metrics pk_n_bar_support_resistance_metrics; Type: CONSTRAINT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.n_bar_support_resistance_metrics
    ADD CONSTRAINT pk_n_bar_support_resistance_metrics PRIMARY KEY (instrument_id, timeframe, tf_id);


--
-- Name: trend_pivot_metrics trend_pivot_metrics_pkey; Type: CONSTRAINT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.trend_pivot_metrics
    ADD CONSTRAINT trend_pivot_metrics_pkey PRIMARY KEY (id);


--
-- Name: candle_matrix_metrics uq_cmm_unique; Type: CONSTRAINT; Schema: core_app_mcx; Owner: rathore
--

ALTER TABLE ONLY core_app_mcx.candle_matrix_metrics
    ADD CONSTRAINT uq_cmm_unique UNIQUE (instrument_id, timeframe, tf_id);


--
-- Name: candle_matrix_metrics candle_matrix_metrics_pkey; Type: CONSTRAINT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.candle_matrix_metrics
    ADD CONSTRAINT candle_matrix_metrics_pkey PRIMARY KEY (symbol, timeframe, tf_id);


--
-- Name: candle_nbar_state candle_nbar_state_pkey; Type: CONSTRAINT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.candle_nbar_state
    ADD CONSTRAINT candle_nbar_state_pkey PRIMARY KEY (symbol, timeframe, tf_id);


--
-- Name: pipeline_step_tracker pipeline_step_tracker_pkey; Type: CONSTRAINT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.pipeline_step_tracker
    ADD CONSTRAINT pipeline_step_tracker_pkey PRIMARY KEY (tracker_name, instrument_id, timeframe);


--
-- Name: pivot_candle_pivots pivot_candle_pivots_pkey; Type: CONSTRAINT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.pivot_candle_pivots
    ADD CONSTRAINT pivot_candle_pivots_pkey PRIMARY KEY (symbol, timeframe, start_at);


--
-- Name: pivot_candles pivot_candles_pkey; Type: CONSTRAINT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.pivot_candles
    ADD CONSTRAINT pivot_candles_pkey PRIMARY KEY (symbol, timeframe, opening_pivot_tf_id);


--
-- Name: pivot_metrics pivot_metrics_pkey; Type: CONSTRAINT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.pivot_metrics
    ADD CONSTRAINT pivot_metrics_pkey PRIMARY KEY (id);


--
-- Name: fractal_trend_pivots_metrics pk_fractal_trend_pivots_metrics_nfo; Type: CONSTRAINT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.fractal_trend_pivots_metrics
    ADD CONSTRAINT pk_fractal_trend_pivots_metrics_nfo PRIMARY KEY (symbol, tf_id, timeframe);


--
-- Name: n_bar_pivot_metrics pk_n_bar_pivot_metrics_nfo; Type: CONSTRAINT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.n_bar_pivot_metrics
    ADD CONSTRAINT pk_n_bar_pivot_metrics_nfo PRIMARY KEY (symbol, tf_id, timeframe);


--
-- Name: n_bar_support_resistance_metrics pk_n_bar_support_resistance_metrics; Type: CONSTRAINT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.n_bar_support_resistance_metrics
    ADD CONSTRAINT pk_n_bar_support_resistance_metrics PRIMARY KEY (instrument_id, timeframe, tf_id);


--
-- Name: trend_pivot_metrics trend_pivot_metrics_pkey; Type: CONSTRAINT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.trend_pivot_metrics
    ADD CONSTRAINT trend_pivot_metrics_pkey PRIMARY KEY (id);


--
-- Name: candle_matrix_metrics uq_cmm_unique; Type: CONSTRAINT; Schema: core_app_nfo; Owner: rathore
--

ALTER TABLE ONLY core_app_nfo.candle_matrix_metrics
    ADD CONSTRAINT uq_cmm_unique UNIQUE (instrument_id, timeframe, tf_id);


--
-- Name: candle_matrix_metrics candle_matrix_metrics_pkey; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.candle_matrix_metrics
    ADD CONSTRAINT candle_matrix_metrics_pkey PRIMARY KEY (symbol, timeframe, tf_id);


--
-- Name: candle_nbar_state candle_nbar_state_pkey; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.candle_nbar_state
    ADD CONSTRAINT candle_nbar_state_pkey PRIMARY KEY (symbol, timeframe, tf_id);


--
-- Name: phase_c_nbar_mtf_context phase_c_nbar_mtf_context_pkey; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.phase_c_nbar_mtf_context
    ADD CONSTRAINT phase_c_nbar_mtf_context_pkey PRIMARY KEY (instrument_id, as_of_date);


--
-- Name: phase_c_nbar_structural_context phase_c_nbar_structural_context_pkey; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.phase_c_nbar_structural_context
    ADD CONSTRAINT phase_c_nbar_structural_context_pkey PRIMARY KEY (instrument_id, timeframe, tf_id);


--
-- Name: phase_d_structural_signal_scores phase_d_structural_signal_scores_pkey; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.phase_d_structural_signal_scores
    ADD CONSTRAINT phase_d_structural_signal_scores_pkey PRIMARY KEY (instrument_id, timeframe, tf_id);


--
-- Name: phase_d_watchlist_structural_rankings phase_d_watchlist_structural_rankings_pkey; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.phase_d_watchlist_structural_rankings
    ADD CONSTRAINT phase_d_watchlist_structural_rankings_pkey PRIMARY KEY (instrument_id, as_of_date);


--
-- Name: pipeline_step_tracker pipeline_step_tracker_pkey; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.pipeline_step_tracker
    ADD CONSTRAINT pipeline_step_tracker_pkey PRIMARY KEY (tracker_name, instrument_id, timeframe);


--
-- Name: pivot_candle_pivots pivot_candle_pivots_pkey; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.pivot_candle_pivots
    ADD CONSTRAINT pivot_candle_pivots_pkey PRIMARY KEY (symbol, timeframe, start_at);


--
-- Name: pivot_candles pivot_candles_pkey; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.pivot_candles
    ADD CONSTRAINT pivot_candles_pkey PRIMARY KEY (symbol, timeframe, opening_pivot_tf_id);


--
-- Name: pivot_metrics pivot_metrics_pkey; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.pivot_metrics
    ADD CONSTRAINT pivot_metrics_pkey PRIMARY KEY (id);


--
-- Name: fractal_trend_pivots_metrics pk_fractal_trend_pivots_metrics_nse; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.fractal_trend_pivots_metrics
    ADD CONSTRAINT pk_fractal_trend_pivots_metrics_nse PRIMARY KEY (symbol, tf_id, timeframe);


--
-- Name: n_bar_pivot_metrics pk_n_bar_pivot_metrics_nse; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.n_bar_pivot_metrics
    ADD CONSTRAINT pk_n_bar_pivot_metrics_nse PRIMARY KEY (instrument_id, timeframe, tf_id);


--
-- Name: n_bar_support_resistance_metrics pk_n_bar_support_resistance_metrics_nse; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.n_bar_support_resistance_metrics
    ADD CONSTRAINT pk_n_bar_support_resistance_metrics_nse PRIMARY KEY (instrument_id, timeframe, tf_id);


--
-- Name: trend_pivot_metrics trend_pivot_metrics_pkey; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.trend_pivot_metrics
    ADD CONSTRAINT trend_pivot_metrics_pkey PRIMARY KEY (id);


--
-- Name: candle_matrix_metrics uq_candle_matrix_metrics_instrument_tf_tfid; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.candle_matrix_metrics
    ADD CONSTRAINT uq_candle_matrix_metrics_instrument_tf_tfid UNIQUE (instrument_id, timeframe, tf_id);


--
-- Name: candle_nbar_state uq_candle_nbar_state_instrument_tf_tfid; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.candle_nbar_state
    ADD CONSTRAINT uq_candle_nbar_state_instrument_tf_tfid UNIQUE (instrument_id, timeframe, tf_id);


--
-- Name: candle_matrix_metrics uq_cmm_unique; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.candle_matrix_metrics
    ADD CONSTRAINT uq_cmm_unique UNIQUE (instrument_id, timeframe, tf_id);


--
-- Name: fractal_trend_pivots_metrics uq_fractal_trend_pivots_metrics_instrument_tf_tfid; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.fractal_trend_pivots_metrics
    ADD CONSTRAINT uq_fractal_trend_pivots_metrics_instrument_tf_tfid UNIQUE (instrument_id, timeframe, tf_id);


--
-- Name: n_bar_pivot_metrics uq_n_bar_pivot_metrics_instrument_tf_tfid; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.n_bar_pivot_metrics
    ADD CONSTRAINT uq_n_bar_pivot_metrics_instrument_tf_tfid UNIQUE (instrument_id, timeframe, tf_id);


--
-- Name: pivot_candle_pivots uq_pivot_candle_pivots_instrument_tf_opening; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.pivot_candle_pivots
    ADD CONSTRAINT uq_pivot_candle_pivots_instrument_tf_opening UNIQUE (instrument_id, timeframe, opening_pivot_candle_id);


--
-- Name: pivot_candles uq_pivot_candles_instrument_tf_opening; Type: CONSTRAINT; Schema: core_app_nse; Owner: rathore
--

ALTER TABLE ONLY core_app_nse.pivot_candles
    ADD CONSTRAINT uq_pivot_candles_instrument_tf_opening UNIQUE (instrument_id, timeframe, opening_pivot_tf_id);


--
-- Name: nse_market_activity_market_report nse_market_activity_market_report_pkey; Type: CONSTRAINT; Schema: exchange; Owner: rathore
--

ALTER TABLE ONLY exchange.nse_market_activity_market_report
    ADD CONSTRAINT nse_market_activity_market_report_pkey PRIMARY KEY (trade_date);


--
-- Name: instrument_master instrument_master_instrument_key_key; Type: CONSTRAINT; Schema: exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY exchange_symbol.instrument_master
    ADD CONSTRAINT instrument_master_instrument_key_key UNIQUE (instrument_key);


--
-- Name: instrument_master instrument_master_pkey; Type: CONSTRAINT; Schema: exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY exchange_symbol.instrument_master
    ADD CONSTRAINT instrument_master_pkey PRIMARY KEY (instrument_id);


--
-- Name: account_capital_state account_capital_state_pkey; Type: CONSTRAINT; Schema: market_intelligence; Owner: rathore
--

ALTER TABLE ONLY market_intelligence.account_capital_state
    ADD CONSTRAINT account_capital_state_pkey PRIMARY KEY (trade_date);


--
-- Name: market_breadth_snapshot market_breadth_snapshot_pkey; Type: CONSTRAINT; Schema: market_intelligence; Owner: rathore
--

ALTER TABLE ONLY market_intelligence.market_breadth_snapshot
    ADD CONSTRAINT market_breadth_snapshot_pkey PRIMARY KEY (trade_date, breadth_scope);


--
-- Name: market_regime_state market_regime_state_pkey; Type: CONSTRAINT; Schema: market_intelligence; Owner: rathore
--

ALTER TABLE ONLY market_intelligence.market_regime_state
    ADD CONSTRAINT market_regime_state_pkey PRIMARY KEY (trade_date);


--
-- Name: meta_signal_results meta_signal_results_pkey; Type: CONSTRAINT; Schema: market_intelligence; Owner: rathore
--

ALTER TABLE ONLY market_intelligence.meta_signal_results
    ADD CONSTRAINT meta_signal_results_pkey PRIMARY KEY (trade_date, instrument_id, timeframe);


--
-- Name: sector_heatmap sector_heatmap_pkey; Type: CONSTRAINT; Schema: market_intelligence; Owner: rathore
--

ALTER TABLE ONLY market_intelligence.sector_heatmap
    ADD CONSTRAINT sector_heatmap_pkey PRIMARY KEY (trade_date, sector_name);


--
-- Name: trade_execution_plan trade_execution_plan_pkey; Type: CONSTRAINT; Schema: market_intelligence; Owner: rathore
--

ALTER TABLE ONLY market_intelligence.trade_execution_plan
    ADD CONSTRAINT trade_execution_plan_pkey PRIMARY KEY (trade_date, instrument_id, timeframe);


--
-- Name: trade_outcome_attribution trade_outcome_attribution_pkey; Type: CONSTRAINT; Schema: market_intelligence; Owner: rathore
--

ALTER TABLE ONLY market_intelligence.trade_outcome_attribution
    ADD CONSTRAINT trade_outcome_attribution_pkey PRIMARY KEY (instrument_id, timeframe, trade_date);


--
-- Name: trade_outcome_events trade_outcome_events_pkey; Type: CONSTRAINT; Schema: market_intelligence; Owner: rathore
--

ALTER TABLE ONLY market_intelligence.trade_outcome_events
    ADD CONSTRAINT trade_outcome_events_pkey PRIMARY KEY (trade_date, instrument_id, timeframe, event_seq);


--
-- Name: trade_outcome_feedback trade_outcome_feedback_pkey; Type: CONSTRAINT; Schema: market_intelligence; Owner: rathore
--

ALTER TABLE ONLY market_intelligence.trade_outcome_feedback
    ADD CONSTRAINT trade_outcome_feedback_pkey PRIMARY KEY (signal_type, timeframe, market_regime, side_preference);


--
-- Name: trade_outcomes trade_outcomes_pkey; Type: CONSTRAINT; Schema: market_intelligence; Owner: rathore
--

ALTER TABLE ONLY market_intelligence.trade_outcomes
    ADD CONSTRAINT trade_outcomes_pkey PRIMARY KEY (trade_date, instrument_id, timeframe);


--
-- Name: watchlist_alerts watchlist_alerts_pkey; Type: CONSTRAINT; Schema: market_intelligence; Owner: rathore
--

ALTER TABLE ONLY market_intelligence.watchlist_alerts
    ADD CONSTRAINT watchlist_alerts_pkey PRIMARY KEY (trade_date, instrument_id, timeframe, dedup_key);


--
-- Name: watchlist_candidates watchlist_candidates_pkey; Type: CONSTRAINT; Schema: market_intelligence; Owner: rathore
--

ALTER TABLE ONLY market_intelligence.watchlist_candidates
    ADD CONSTRAINT watchlist_candidates_pkey PRIMARY KEY (trade_date, instrument_id, timeframe);


--
-- Name: eod_reconciliation_log eod_reconciliation_log_pkey; Type: CONSTRAINT; Schema: market_mcx; Owner: rathore
--

ALTER TABLE ONLY market_mcx.eod_reconciliation_log
    ADD CONSTRAINT eod_reconciliation_log_pkey PRIMARY KEY (reconciliation_id);


--
-- Name: market_candle_feature_fast market_candle_feature_fast_pkey; Type: CONSTRAINT; Schema: market_mcx; Owner: rathore
--

ALTER TABLE ONLY market_mcx.market_candle_feature_fast
    ADD CONSTRAINT market_candle_feature_fast_pkey PRIMARY KEY (bar_start_ts, instrument_id, timeframe);


--
-- Name: market_candle_pivot market_candle_pivot_pkey; Type: CONSTRAINT; Schema: market_mcx; Owner: rathore
--

ALTER TABLE ONLY market_mcx.market_candle_pivot
    ADD CONSTRAINT market_candle_pivot_pkey PRIMARY KEY (bar_start_ts, instrument_id, timeframe);


--
-- Name: market_candle market_candle_pkey; Type: CONSTRAINT; Schema: market_mcx; Owner: rathore
--

ALTER TABLE ONLY market_mcx.market_candle
    ADD CONSTRAINT market_candle_pkey PRIMARY KEY (bar_start_ts, instrument_id, timeframe);


--
-- Name: market_candle_sma_state market_candle_sma_state_pkey; Type: CONSTRAINT; Schema: market_mcx; Owner: rathore
--

ALTER TABLE ONLY market_mcx.market_candle_sma_state
    ADD CONSTRAINT market_candle_sma_state_pkey PRIMARY KEY (bar_start_ts, instrument_id, timeframe);


--
-- Name: market_day_status market_day_status_pkey; Type: CONSTRAINT; Schema: market_mcx; Owner: rathore
--

ALTER TABLE ONLY market_mcx.market_day_status
    ADD CONSTRAINT market_day_status_pkey PRIMARY KEY (trade_date);


--
-- Name: market_candle uq_market_candle_unique; Type: CONSTRAINT; Schema: market_mcx; Owner: rathore
--

ALTER TABLE ONLY market_mcx.market_candle
    ADD CONSTRAINT uq_market_candle_unique UNIQUE (instrument_id, timeframe, bar_start_ts);


--
-- Name: market_candle_pivot uq_pivot_unique; Type: CONSTRAINT; Schema: market_mcx; Owner: rathore
--

ALTER TABLE ONLY market_mcx.market_candle_pivot
    ADD CONSTRAINT uq_pivot_unique UNIQUE (instrument_id, timeframe, bar_start_ts);


--
-- Name: market_candle_sma_state uq_sma_state_unique; Type: CONSTRAINT; Schema: market_mcx; Owner: rathore
--

ALTER TABLE ONLY market_mcx.market_candle_sma_state
    ADD CONSTRAINT uq_sma_state_unique UNIQUE (instrument_id, timeframe, tf_id);


--
-- Name: eod_reconciliation_log eod_reconciliation_log_pkey; Type: CONSTRAINT; Schema: market_nfo; Owner: rathore
--

ALTER TABLE ONLY market_nfo.eod_reconciliation_log
    ADD CONSTRAINT eod_reconciliation_log_pkey PRIMARY KEY (reconciliation_id);


--
-- Name: market_candle_feature_fast market_candle_feature_fast_pkey; Type: CONSTRAINT; Schema: market_nfo; Owner: rathore
--

ALTER TABLE ONLY market_nfo.market_candle_feature_fast
    ADD CONSTRAINT market_candle_feature_fast_pkey PRIMARY KEY (bar_start_ts, instrument_id, timeframe);


--
-- Name: market_candle_pivot market_candle_pivot_pkey; Type: CONSTRAINT; Schema: market_nfo; Owner: rathore
--

ALTER TABLE ONLY market_nfo.market_candle_pivot
    ADD CONSTRAINT market_candle_pivot_pkey PRIMARY KEY (bar_start_ts, instrument_id, timeframe);


--
-- Name: market_candle market_candle_pkey; Type: CONSTRAINT; Schema: market_nfo; Owner: rathore
--

ALTER TABLE ONLY market_nfo.market_candle
    ADD CONSTRAINT market_candle_pkey PRIMARY KEY (bar_start_ts, instrument_id, timeframe);


--
-- Name: market_candle_sma_state market_candle_sma_state_pkey; Type: CONSTRAINT; Schema: market_nfo; Owner: rathore
--

ALTER TABLE ONLY market_nfo.market_candle_sma_state
    ADD CONSTRAINT market_candle_sma_state_pkey PRIMARY KEY (bar_start_ts, instrument_id, timeframe);


--
-- Name: market_day_status market_day_status_pkey; Type: CONSTRAINT; Schema: market_nfo; Owner: rathore
--

ALTER TABLE ONLY market_nfo.market_day_status
    ADD CONSTRAINT market_day_status_pkey PRIMARY KEY (trade_date);


--
-- Name: market_candle uq_market_candle_unique; Type: CONSTRAINT; Schema: market_nfo; Owner: rathore
--

ALTER TABLE ONLY market_nfo.market_candle
    ADD CONSTRAINT uq_market_candle_unique UNIQUE (instrument_id, timeframe, bar_start_ts);


--
-- Name: market_candle_pivot uq_pivot_unique; Type: CONSTRAINT; Schema: market_nfo; Owner: rathore
--

ALTER TABLE ONLY market_nfo.market_candle_pivot
    ADD CONSTRAINT uq_pivot_unique UNIQUE (instrument_id, timeframe, bar_start_ts);


--
-- Name: market_candle_sma_state uq_sma_state_unique; Type: CONSTRAINT; Schema: market_nfo; Owner: rathore
--

ALTER TABLE ONLY market_nfo.market_candle_sma_state
    ADD CONSTRAINT uq_sma_state_unique UNIQUE (instrument_id, timeframe, tf_id);


--
-- Name: eod_reconciliation_log eod_reconciliation_log_pkey; Type: CONSTRAINT; Schema: market_nse; Owner: rathore
--

ALTER TABLE ONLY market_nse.eod_reconciliation_log
    ADD CONSTRAINT eod_reconciliation_log_pkey PRIMARY KEY (reconciliation_id);


--
-- Name: hour_candle_gap_audit hour_candle_gap_audit_pkey; Type: CONSTRAINT; Schema: market_nse; Owner: rathore
--

ALTER TABLE ONLY market_nse.hour_candle_gap_audit
    ADD CONSTRAINT hour_candle_gap_audit_pkey PRIMARY KEY (instrument_id, trade_date, timeframe);


--
-- Name: market_candle_feature_fast market_candle_feature_fast_pkey; Type: CONSTRAINT; Schema: market_nse; Owner: rathore
--

ALTER TABLE ONLY market_nse.market_candle_feature_fast
    ADD CONSTRAINT market_candle_feature_fast_pkey PRIMARY KEY (bar_start_ts, instrument_id, timeframe);


--
-- Name: market_candle_pivot market_candle_pivot_pkey; Type: CONSTRAINT; Schema: market_nse; Owner: rathore
--

ALTER TABLE ONLY market_nse.market_candle_pivot
    ADD CONSTRAINT market_candle_pivot_pkey PRIMARY KEY (bar_start_ts, instrument_id, timeframe);


--
-- Name: market_candle_sma_state market_candle_sma_state_pkey; Type: CONSTRAINT; Schema: market_nse; Owner: rathore
--

ALTER TABLE ONLY market_nse.market_candle_sma_state
    ADD CONSTRAINT market_candle_sma_state_pkey PRIMARY KEY (bar_start_ts, instrument_id, timeframe);


--
-- Name: market_day_status market_day_status_pkey; Type: CONSTRAINT; Schema: market_nse; Owner: rathore
--

ALTER TABLE ONLY market_nse.market_day_status
    ADD CONSTRAINT market_day_status_pkey PRIMARY KEY (trade_date);


--
-- Name: market_candle uq_market_candle_unique; Type: CONSTRAINT; Schema: market_nse; Owner: rathore
--

ALTER TABLE ONLY market_nse.market_candle
    ADD CONSTRAINT uq_market_candle_unique UNIQUE (instrument_id, timeframe, bar_start_ts);


--
-- Name: market_candle_pivot uq_pivot_unique; Type: CONSTRAINT; Schema: market_nse; Owner: rathore
--

ALTER TABLE ONLY market_nse.market_candle_pivot
    ADD CONSTRAINT uq_pivot_unique UNIQUE (instrument_id, timeframe, bar_start_ts);


--
-- Name: market_candle_sma_state uq_sma_state_unique; Type: CONSTRAINT; Schema: market_nse; Owner: rathore
--

ALTER TABLE ONLY market_nse.market_candle_sma_state
    ADD CONSTRAINT uq_sma_state_unique UNIQUE (instrument_id, timeframe, tf_id);


--
-- Name: instrument_master_derivative instrument_master_derivative_pkey; Type: CONSTRAINT; Schema: mcx_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY mcx_exchange_symbol.instrument_master_derivative
    ADD CONSTRAINT instrument_master_derivative_pkey PRIMARY KEY (instrument_id);


--
-- Name: instrument_master instrument_master_pkey; Type: CONSTRAINT; Schema: mcx_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY mcx_exchange_symbol.instrument_master
    ADD CONSTRAINT instrument_master_pkey PRIMARY KEY (instrument_id);


--
-- Name: phase0_run_audit phase0_run_audit_pkey; Type: CONSTRAINT; Schema: mcx_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY mcx_exchange_symbol.phase0_run_audit
    ADD CONSTRAINT phase0_run_audit_pkey PRIMARY KEY (run_id);


--
-- Name: instrument_master uq_mcx_instrument_master_instrument_key; Type: CONSTRAINT; Schema: mcx_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY mcx_exchange_symbol.instrument_master
    ADD CONSTRAINT uq_mcx_instrument_master_instrument_key UNIQUE (instrument_key);


--
-- Name: raw_ticks mcx_tick_data_raw_ticks_pkey; Type: CONSTRAINT; Schema: mcx_tick_data; Owner: rathore
--

ALTER TABLE ONLY mcx_tick_data.raw_ticks
    ADD CONSTRAINT mcx_tick_data_raw_ticks_pkey PRIMARY KEY (tick_id);


--
-- Name: realtime_5m_bar mcx_tick_data_realtime_5m_bar_pkey; Type: CONSTRAINT; Schema: mcx_tick_data; Owner: rathore
--

ALTER TABLE ONLY mcx_tick_data.realtime_5m_bar
    ADD CONSTRAINT mcx_tick_data_realtime_5m_bar_pkey PRIMARY KEY (symbol, bar_start_ts);


--
-- Name: csv_ingestion_audit csv_ingestion_audit_pkey; Type: CONSTRAINT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.csv_ingestion_audit
    ADD CONSTRAINT csv_ingestion_audit_pkey PRIMARY KEY (id);


--
-- Name: engine_error_log engine_error_log_pkey; Type: CONSTRAINT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.engine_error_log
    ADD CONSTRAINT engine_error_log_pkey PRIMARY KEY (error_id);


--
-- Name: engine_run_tracker engine_run_tracker_pkey; Type: CONSTRAINT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.engine_run_tracker
    ADD CONSTRAINT engine_run_tracker_pkey PRIMARY KEY (tracker_id);


--
-- Name: htf_rebuild_watermark htf_rebuild_watermark_pkey; Type: CONSTRAINT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.htf_rebuild_watermark
    ADD CONSTRAINT htf_rebuild_watermark_pkey PRIMARY KEY (instrument_id, timeframe);


--
-- Name: nse_market_holiday nse_market_holiday_pkey; Type: CONSTRAINT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.nse_market_holiday
    ADD CONSTRAINT nse_market_holiday_pkey PRIMARY KEY (trade_date, exchange_code);


--
-- Name: pipeline_run_metrics pipeline_run_metrics_pkey; Type: CONSTRAINT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.pipeline_run_metrics
    ADD CONSTRAINT pipeline_run_metrics_pkey PRIMARY KEY (run_id);


--
-- Name: shoonya_api_call_audit shoonya_api_call_audit_pkey; Type: CONSTRAINT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.shoonya_api_call_audit
    ADD CONSTRAINT shoonya_api_call_audit_pkey PRIMARY KEY (shoonya_api_call_audit_id);


--
-- Name: sma_state_checkpoint sma_state_checkpoint_pkey; Type: CONSTRAINT; Schema: meta_data; Owner: rathore
--

ALTER TABLE ONLY meta_data.sma_state_checkpoint
    ADD CONSTRAINT sma_state_checkpoint_pkey PRIMARY KEY (schema_name, instrument_id, timeframe);


--
-- Name: csv_ingestion_audit csv_ingestion_audit_pkey; Type: CONSTRAINT; Schema: metadata; Owner: rathore
--

ALTER TABLE ONLY metadata.csv_ingestion_audit
    ADD CONSTRAINT csv_ingestion_audit_pkey PRIMARY KEY (id);


--
-- Name: instrument_bootstrap_audit instrument_bootstrap_audit_pkey; Type: CONSTRAINT; Schema: metadata; Owner: rathore
--

ALTER TABLE ONLY metadata.instrument_bootstrap_audit
    ADD CONSTRAINT instrument_bootstrap_audit_pkey PRIMARY KEY (instrument_bootstrap_audit_id);


--
-- Name: pipeline_step_run_audit pipeline_step_run_audit_pkey; Type: CONSTRAINT; Schema: metadata; Owner: rathore
--

ALTER TABLE ONLY metadata.pipeline_step_run_audit
    ADD CONSTRAINT pipeline_step_run_audit_pkey PRIMARY KEY (run_audit_id);


--
-- Name: instrument_master_derivative instrument_master_derivative_pkey; Type: CONSTRAINT; Schema: nfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nfo_exchange_symbol.instrument_master_derivative
    ADD CONSTRAINT instrument_master_derivative_pkey PRIMARY KEY (instrument_id);


--
-- Name: instrument_master instrument_master_pkey; Type: CONSTRAINT; Schema: nfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nfo_exchange_symbol.instrument_master
    ADD CONSTRAINT instrument_master_pkey PRIMARY KEY (instrument_id);


--
-- Name: phase0_run_audit phase0_run_audit_pkey; Type: CONSTRAINT; Schema: nfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nfo_exchange_symbol.phase0_run_audit
    ADD CONSTRAINT phase0_run_audit_pkey PRIMARY KEY (run_id);


--
-- Name: instrument_master uq_nfo_instrument_master_instrument_key; Type: CONSTRAINT; Schema: nfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nfo_exchange_symbol.instrument_master
    ADD CONSTRAINT uq_nfo_instrument_master_instrument_key UNIQUE (instrument_key);


--
-- Name: raw_ticks nfo_tick_data_raw_ticks_pkey; Type: CONSTRAINT; Schema: nfo_tick_data; Owner: rathore
--

ALTER TABLE ONLY nfo_tick_data.raw_ticks
    ADD CONSTRAINT nfo_tick_data_raw_ticks_pkey PRIMARY KEY (tick_id);


--
-- Name: realtime_5m_bar nfo_tick_data_realtime_5m_bar_pkey; Type: CONSTRAINT; Schema: nfo_tick_data; Owner: rathore
--

ALTER TABLE ONLY nfo_tick_data.realtime_5m_bar
    ADD CONSTRAINT nfo_tick_data_realtime_5m_bar_pkey PRIMARY KEY (symbol, bar_start_ts);


--
-- Name: index_master index_master_pkey; Type: CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.index_master
    ADD CONSTRAINT index_master_pkey PRIMARY KEY (index_id);


--
-- Name: instrument_chart_bootstrap instrument_chart_bootstrap_instrument_id_key; Type: CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.instrument_chart_bootstrap
    ADD CONSTRAINT instrument_chart_bootstrap_instrument_id_key UNIQUE (instrument_id);


--
-- Name: instrument_chart_bootstrap instrument_chart_bootstrap_pkey; Type: CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.instrument_chart_bootstrap
    ADD CONSTRAINT instrument_chart_bootstrap_pkey PRIMARY KEY (bootstrap_id);


--
-- Name: instrument_master_equity instrument_master_equity_pkey; Type: CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.instrument_master_equity
    ADD CONSTRAINT instrument_master_equity_pkey PRIMARY KEY (instrument_id);


--
-- Name: instrument_master instrument_master_pkey; Type: CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.instrument_master
    ADD CONSTRAINT instrument_master_pkey PRIMARY KEY (instrument_id);


--
-- Name: index_constituent_map nse_index_constituent_map_pkey; Type: CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.index_constituent_map
    ADD CONSTRAINT nse_index_constituent_map_pkey PRIMARY KEY (index_id, instrument_id, trade_date);


--
-- Name: instrument_all_time_levels nse_instrument_all_time_levels_pkey; Type: CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.instrument_all_time_levels
    ADD CONSTRAINT nse_instrument_all_time_levels_pkey PRIMARY KEY (instrument_id, level_type);


--
-- Name: phase0_run_audit phase0_run_audit_pkey; Type: CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.phase0_run_audit
    ADD CONSTRAINT phase0_run_audit_pkey PRIMARY KEY (run_id);


--
-- Name: index_master uq_nse_index_master_normalized_name; Type: CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.index_master
    ADD CONSTRAINT uq_nse_index_master_normalized_name UNIQUE (normalized_index_name);


--
-- Name: instrument_master uq_nse_instrument_master_instrument_key; Type: CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.instrument_master
    ADD CONSTRAINT uq_nse_instrument_master_instrument_key UNIQUE (instrument_key);


--
-- Name: raw_ticks nse_tick_data_raw_ticks_pkey; Type: CONSTRAINT; Schema: nse_tick_data; Owner: rathore
--

ALTER TABLE ONLY nse_tick_data.raw_ticks
    ADD CONSTRAINT nse_tick_data_raw_ticks_pkey PRIMARY KEY (tick_id);


--
-- Name: realtime_5m_bar nse_tick_data_realtime_5m_bar_pkey; Type: CONSTRAINT; Schema: nse_tick_data; Owner: rathore
--

ALTER TABLE ONLY nse_tick_data.realtime_5m_bar
    ADD CONSTRAINT nse_tick_data_realtime_5m_bar_pkey PRIMARY KEY (symbol, bar_start_ts);


--
-- Name: market_regime market_regime_pkey; Type: CONSTRAINT; Schema: signals_nse; Owner: rathore
--

ALTER TABLE ONLY signals_nse.market_regime
    ADD CONSTRAINT market_regime_pkey PRIMARY KEY (instrument_id, timeframe, tf_id);


--
-- Name: momentum_liquidity momentum_liquidity_pkey; Type: CONSTRAINT; Schema: signals_nse; Owner: rathore
--

ALTER TABLE ONLY signals_nse.momentum_liquidity
    ADD CONSTRAINT momentum_liquidity_pkey PRIMARY KEY (instrument_id, timeframe, tf_id);


--
-- Name: structural_context structural_context_pkey; Type: CONSTRAINT; Schema: signals_nse; Owner: rathore
--

ALTER TABLE ONLY signals_nse.structural_context
    ADD CONSTRAINT structural_context_pkey PRIMARY KEY (instrument_id, timeframe, tf_id);


--
-- Name: symbol_signal symbol_signal_pkey; Type: CONSTRAINT; Schema: signals_nse; Owner: rathore
--

ALTER TABLE ONLY signals_nse.symbol_signal
    ADD CONSTRAINT symbol_signal_pkey PRIMARY KEY (instrument_id, timeframe, tf_id);


--
-- Name: volatility_breakout volatility_breakout_pkey; Type: CONSTRAINT; Schema: signals_nse; Owner: rathore
--

ALTER TABLE ONLY signals_nse.volatility_breakout
    ADD CONSTRAINT volatility_breakout_pkey PRIMARY KEY (instrument_id, timeframe, tf_id);


--
-- Name: broker_chart_api_raw broker_chart_api_raw_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.broker_chart_api_raw
    ADD CONSTRAINT broker_chart_api_raw_pkey PRIMARY KEY (cache_id);


--
-- Name: chart_csv_candle_raw chart_csv_candle_raw_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.chart_csv_candle_raw
    ADD CONSTRAINT chart_csv_candle_raw_pkey PRIMARY KEY (instrument_id, timeframe, bar_start_ts);


--
-- Name: chart_csv_eod chart_csv_eod_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.chart_csv_eod
    ADD CONSTRAINT chart_csv_eod_pkey PRIMARY KEY (id);


--
-- Name: chart_csv_file_audit chart_csv_file_audit_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.chart_csv_file_audit
    ADD CONSTRAINT chart_csv_file_audit_pkey PRIMARY KEY (instrument_id, timeframe, source_file);


--
-- Name: market_candle_raw market_candle_raw_instrument_id_timeframe_bar_start_ts_sour_key; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.market_candle_raw
    ADD CONSTRAINT market_candle_raw_instrument_id_timeframe_bar_start_ts_sour_key UNIQUE (instrument_id, timeframe, bar_start_ts, source_name);


--
-- Name: market_candle_raw market_candle_raw_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.market_candle_raw
    ADD CONSTRAINT market_candle_raw_pkey PRIMARY KEY (id);


--
-- Name: nse_api_cache nse_api_cache_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_api_cache
    ADD CONSTRAINT nse_api_cache_pkey PRIMARY KEY (api_cache_id);


--
-- Name: nse_bhavcopy_file_audit nse_bhavcopy_file_audit_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_bhavcopy_file_audit
    ADD CONSTRAINT nse_bhavcopy_file_audit_pkey PRIMARY KEY (audit_id);


--
-- Name: nse_bhavcopy_index_eod nse_bhavcopy_index_eod_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_bhavcopy_index_eod
    ADD CONSTRAINT nse_bhavcopy_index_eod_pkey PRIMARY KEY (trade_date, index_name);


--
-- Name: nse_bhavcopy_section nse_bhavcopy_section_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_bhavcopy_section
    ADD CONSTRAINT nse_bhavcopy_section_pkey PRIMARY KEY (trade_date, file_name, row_number);


--
-- Name: nse_bhavcopy_security_eod nse_bhavcopy_security_eod_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_bhavcopy_security_eod
    ADD CONSTRAINT nse_bhavcopy_security_eod_pkey PRIMARY KEY (trade_date, symbol, series);


--
-- Name: nse_eod_download_audit nse_eod_download_audit_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_eod_download_audit
    ADD CONSTRAINT nse_eod_download_audit_pkey PRIMARY KEY (audit_id);


--
-- Name: nse_eod_equity nse_eod_equity_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_eod_equity
    ADD CONSTRAINT nse_eod_equity_pkey PRIMARY KEY (trade_date, symbol);


--
-- Name: nse_eod_index nse_eod_index_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_eod_index
    ADD CONSTRAINT nse_eod_index_pkey PRIMARY KEY (trade_date, index_name);


--
-- Name: nse_hl_daily_levels nse_hl_daily_levels_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_hl_daily_levels
    ADD CONSTRAINT nse_hl_daily_levels_pkey PRIMARY KEY (trade_date, security_name, new_status);


--
-- Name: nse_hl_file_audit nse_hl_file_audit_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_hl_file_audit
    ADD CONSTRAINT nse_hl_file_audit_pkey PRIMARY KEY (trade_date, source_file);


--
-- Name: nse_index_constituent_download_audit nse_index_constituent_download_audit_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_index_constituent_download_audit
    ADD CONSTRAINT nse_index_constituent_download_audit_pkey PRIMARY KEY (trade_date, index_name);


--
-- Name: nse_index_constituent_eod nse_index_constituent_eod_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_index_constituent_eod
    ADD CONSTRAINT nse_index_constituent_eod_pkey PRIMARY KEY (trade_date, symbol);


--
-- Name: nse_index_eod_run_tracker nse_index_eod_run_tracker_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_index_eod_run_tracker
    ADD CONSTRAINT nse_index_eod_run_tracker_pkey PRIMARY KEY (trade_date, run_type);


--
-- Name: nse_market_activity_index_eod nse_market_activity_index_eod_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_market_activity_index_eod
    ADD CONSTRAINT nse_market_activity_index_eod_pkey PRIMARY KEY (trade_date, index_name);


--
-- Name: nse_market_activity_market_report nse_market_activity_market_report_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_market_activity_market_report
    ADD CONSTRAINT nse_market_activity_market_report_pkey PRIMARY KEY (trade_date);


--
-- Name: nse_market_activity_report nse_market_activity_report_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_market_activity_report
    ADD CONSTRAINT nse_market_activity_report_pkey PRIMARY KEY (trade_date);


--
-- Name: nse_pd_file_audit nse_pd_file_audit_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_pd_file_audit
    ADD CONSTRAINT nse_pd_file_audit_pkey PRIMARY KEY (trade_date, source_file);


--
-- Name: nse_pd_index_eod nse_pd_index_eod_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_pd_index_eod
    ADD CONSTRAINT nse_pd_index_eod_pkey PRIMARY KEY (pd_stage_id);


--
-- Name: nse_pr_file_audit nse_pr_file_audit_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_pr_file_audit
    ADD CONSTRAINT nse_pr_file_audit_pkey PRIMARY KEY (trade_date, source_file);


--
-- Name: nse_pr_index_eod nse_pr_index_eod_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_pr_index_eod
    ADD CONSTRAINT nse_pr_index_eod_pkey PRIMARY KEY (trade_date, security_name);


--
-- Name: phase_a_file_checkpoint phase_a_file_checkpoint_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.phase_a_file_checkpoint
    ADD CONSTRAINT phase_a_file_checkpoint_pkey PRIMARY KEY (source_type, file_name);


--
-- Name: phase_a_run_audit phase_a_run_audit_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.phase_a_run_audit
    ADD CONSTRAINT phase_a_run_audit_pkey PRIMARY KEY (run_id);


--
-- Name: phase_a_run_tracker phase_a_run_tracker_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.phase_a_run_tracker
    ADD CONSTRAINT phase_a_run_tracker_pkey PRIMARY KEY (run_id);


--
-- Name: phase_a_step_run_audit phase_a_step_run_audit_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.phase_a_step_run_audit
    ADD CONSTRAINT phase_a_step_run_audit_pkey PRIMARY KEY (step_run_id);


--
-- Name: phase_a_substep_tracker phase_a_substep_tracker_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.phase_a_substep_tracker
    ADD CONSTRAINT phase_a_substep_tracker_pkey PRIMARY KEY (pipeline_name, step_name, substep_name);


--
-- Name: rest_unavailable_symbols rest_unavailable_symbols_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.rest_unavailable_symbols
    ADD CONSTRAINT rest_unavailable_symbols_pkey PRIMARY KEY (exchange_code, symbol);


--
-- Name: step03_candidate_integrity_audit step03_candidate_integrity_audit_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.step03_candidate_integrity_audit
    ADD CONSTRAINT step03_candidate_integrity_audit_pkey PRIMARY KEY (run_id, instrument_id, timeframe);


--
-- Name: step03_reconcile_candidate step03_reconcile_candidate_pkey; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.step03_reconcile_candidate
    ADD CONSTRAINT step03_reconcile_candidate_pkey PRIMARY KEY (candidate_id);


--
-- Name: nse_market_activity_file_audit uq_nse_market_activity_file_audit_trade_date_file_name; Type: CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.nse_market_activity_file_audit
    ADD CONSTRAINT uq_nse_market_activity_file_audit_trade_date_file_name UNIQUE (trade_date, file_name);


--
-- Name: idx_bfo_underlying; Type: INDEX; Schema: bfo_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_bfo_underlying ON bfo_exchange_symbol.instrument_master_derivative USING btree (bse_underlying_instrument_id);


--
-- Name: idx_bse_equity_token; Type: INDEX; Schema: bse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_bse_equity_token ON bse_exchange_symbol.instrument_master_equity USING btree (token);


--
-- Name: idx_bse_instrument_master_symbol; Type: INDEX; Schema: bse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_bse_instrument_master_symbol ON bse_exchange_symbol.instrument_master USING btree (symbol);


--
-- Name: idx_chart_snap_day_unique; Type: INDEX; Schema: charting; Owner: rathore
--

CREATE UNIQUE INDEX idx_chart_snap_day_unique ON charting.instrument_chart_snapshot_day USING btree (instrument_id, date);


--
-- Name: idx_chart_snap_hour_unique; Type: INDEX; Schema: charting; Owner: rathore
--

CREATE UNIQUE INDEX idx_chart_snap_hour_unique ON charting.instrument_chart_snapshot_hour USING btree (instrument_id, date);


--
-- Name: idx_chart_snap_month_unique; Type: INDEX; Schema: charting; Owner: rathore
--

CREATE UNIQUE INDEX idx_chart_snap_month_unique ON charting.instrument_chart_snapshot_month USING btree (instrument_id, date);


--
-- Name: idx_chart_snap_week_unique; Type: INDEX; Schema: charting; Owner: rathore
--

CREATE UNIQUE INDEX idx_chart_snap_week_unique ON charting.instrument_chart_snapshot_week USING btree (instrument_id, date);


--
-- Name: idx_core_app_mcx_cmm_bias; Type: INDEX; Schema: core_app_mcx; Owner: rathore
--

CREATE INDEX idx_core_app_mcx_cmm_bias ON core_app_mcx.candle_matrix_metrics USING btree (timeframe, retrace_bias, trend_strength_score);


--
-- Name: idx_core_app_mcx_cmm_instrument_tf_tfid; Type: INDEX; Schema: core_app_mcx; Owner: rathore
--

CREATE INDEX idx_core_app_mcx_cmm_instrument_tf_tfid ON core_app_mcx.candle_matrix_metrics USING btree (instrument_id, timeframe, tf_id);


--
-- Name: idx_core_app_mcx_cmm_symbol_tf_ts; Type: INDEX; Schema: core_app_mcx; Owner: rathore
--

CREATE INDEX idx_core_app_mcx_cmm_symbol_tf_ts ON core_app_mcx.candle_matrix_metrics USING btree (symbol, timeframe, bar_start_ts);


--
-- Name: idx_core_app_mcx_cns_instrument_tf_tfid; Type: INDEX; Schema: core_app_mcx; Owner: rathore
--

CREATE INDEX idx_core_app_mcx_cns_instrument_tf_tfid ON core_app_mcx.candle_nbar_state USING btree (instrument_id, timeframe, tf_id);


--
-- Name: idx_core_app_mcx_pipeline_step_tracker_lookup; Type: INDEX; Schema: core_app_mcx; Owner: rathore
--

CREATE INDEX idx_core_app_mcx_pipeline_step_tracker_lookup ON core_app_mcx.pipeline_step_tracker USING btree (tracker_name, symbol, timeframe);


--
-- Name: idx_core_app_mcx_pivot_candle_pivots_lookup; Type: INDEX; Schema: core_app_mcx; Owner: rathore
--

CREATE INDEX idx_core_app_mcx_pivot_candle_pivots_lookup ON core_app_mcx.pivot_candle_pivots USING btree (symbol, timeframe, opening_pivot_candle_id);


--
-- Name: idx_core_app_mcx_pivot_candles_lookup; Type: INDEX; Schema: core_app_mcx; Owner: rathore
--

CREATE INDEX idx_core_app_mcx_pivot_candles_lookup ON core_app_mcx.pivot_candles USING btree (symbol, timeframe, opening_pivot_tf_id);


--
-- Name: idx_nbar_sr_instr_tf; Type: INDEX; Schema: core_app_mcx; Owner: rathore
--

CREATE INDEX idx_nbar_sr_instr_tf ON core_app_mcx.n_bar_support_resistance_metrics USING btree (instrument_id, timeframe, tf_id DESC);


--
-- Name: idx_nbar_sr_symbol_tf; Type: INDEX; Schema: core_app_mcx; Owner: rathore
--

CREATE INDEX idx_nbar_sr_symbol_tf ON core_app_mcx.n_bar_support_resistance_metrics USING btree (symbol, timeframe, tf_id DESC);


--
-- Name: idx_core_app_nfo_cmm_bias; Type: INDEX; Schema: core_app_nfo; Owner: rathore
--

CREATE INDEX idx_core_app_nfo_cmm_bias ON core_app_nfo.candle_matrix_metrics USING btree (timeframe, retrace_bias, trend_strength_score);


--
-- Name: idx_core_app_nfo_cmm_instrument_tf_tfid; Type: INDEX; Schema: core_app_nfo; Owner: rathore
--

CREATE INDEX idx_core_app_nfo_cmm_instrument_tf_tfid ON core_app_nfo.candle_matrix_metrics USING btree (instrument_id, timeframe, tf_id);


--
-- Name: idx_core_app_nfo_cmm_symbol_tf_ts; Type: INDEX; Schema: core_app_nfo; Owner: rathore
--

CREATE INDEX idx_core_app_nfo_cmm_symbol_tf_ts ON core_app_nfo.candle_matrix_metrics USING btree (symbol, timeframe, bar_start_ts);


--
-- Name: idx_core_app_nfo_cns_instrument_tf_tfid; Type: INDEX; Schema: core_app_nfo; Owner: rathore
--

CREATE INDEX idx_core_app_nfo_cns_instrument_tf_tfid ON core_app_nfo.candle_nbar_state USING btree (instrument_id, timeframe, tf_id);


--
-- Name: idx_core_app_nfo_pipeline_step_tracker_lookup; Type: INDEX; Schema: core_app_nfo; Owner: rathore
--

CREATE INDEX idx_core_app_nfo_pipeline_step_tracker_lookup ON core_app_nfo.pipeline_step_tracker USING btree (tracker_name, symbol, timeframe);


--
-- Name: idx_core_app_nfo_pivot_candle_pivots_lookup; Type: INDEX; Schema: core_app_nfo; Owner: rathore
--

CREATE INDEX idx_core_app_nfo_pivot_candle_pivots_lookup ON core_app_nfo.pivot_candle_pivots USING btree (symbol, timeframe, opening_pivot_candle_id);


--
-- Name: idx_core_app_nfo_pivot_candles_lookup; Type: INDEX; Schema: core_app_nfo; Owner: rathore
--

CREATE INDEX idx_core_app_nfo_pivot_candles_lookup ON core_app_nfo.pivot_candles USING btree (symbol, timeframe, opening_pivot_tf_id);


--
-- Name: idx_nbar_sr_instr_tf; Type: INDEX; Schema: core_app_nfo; Owner: rathore
--

CREATE INDEX idx_nbar_sr_instr_tf ON core_app_nfo.n_bar_support_resistance_metrics USING btree (instrument_id, timeframe, tf_id DESC);


--
-- Name: idx_nbar_sr_symbol_tf; Type: INDEX; Schema: core_app_nfo; Owner: rathore
--

CREATE INDEX idx_nbar_sr_symbol_tf ON core_app_nfo.n_bar_support_resistance_metrics USING btree (symbol, timeframe, tf_id DESC);


--
-- Name: idx_core_app_nse_cmm_bias; Type: INDEX; Schema: core_app_nse; Owner: rathore
--

CREATE INDEX idx_core_app_nse_cmm_bias ON core_app_nse.candle_matrix_metrics USING btree (timeframe, retrace_bias, trend_strength_score);


--
-- Name: idx_core_app_nse_cmm_instrument_tf_tfid; Type: INDEX; Schema: core_app_nse; Owner: rathore
--

CREATE INDEX idx_core_app_nse_cmm_instrument_tf_tfid ON core_app_nse.candle_matrix_metrics USING btree (instrument_id, timeframe, tf_id);


--
-- Name: idx_core_app_nse_cmm_symbol_tf_ts; Type: INDEX; Schema: core_app_nse; Owner: rathore
--

CREATE INDEX idx_core_app_nse_cmm_symbol_tf_ts ON core_app_nse.candle_matrix_metrics USING btree (symbol, timeframe, bar_start_ts);


--
-- Name: idx_core_app_nse_cns_instrument_tf_tfid; Type: INDEX; Schema: core_app_nse; Owner: rathore
--

CREATE INDEX idx_core_app_nse_cns_instrument_tf_tfid ON core_app_nse.candle_nbar_state USING btree (instrument_id, timeframe, tf_id);


--
-- Name: idx_core_app_nse_pipeline_step_tracker_lookup; Type: INDEX; Schema: core_app_nse; Owner: rathore
--

CREATE INDEX idx_core_app_nse_pipeline_step_tracker_lookup ON core_app_nse.pipeline_step_tracker USING btree (tracker_name, symbol, timeframe);


--
-- Name: idx_core_app_nse_pivot_candle_pivots_lookup; Type: INDEX; Schema: core_app_nse; Owner: rathore
--

CREATE INDEX idx_core_app_nse_pivot_candle_pivots_lookup ON core_app_nse.pivot_candle_pivots USING btree (symbol, timeframe, opening_pivot_candle_id);


--
-- Name: idx_core_app_nse_pivot_candles_lookup; Type: INDEX; Schema: core_app_nse; Owner: rathore
--

CREATE INDEX idx_core_app_nse_pivot_candles_lookup ON core_app_nse.pivot_candles USING btree (symbol, timeframe, opening_pivot_tf_id);


--
-- Name: idx_n_bar_pivot_metrics_instr_tf; Type: INDEX; Schema: core_app_nse; Owner: rathore
--

CREATE INDEX idx_n_bar_pivot_metrics_instr_tf ON core_app_nse.n_bar_pivot_metrics USING btree (instrument_id, timeframe, tf_id DESC);


--
-- Name: idx_n_bar_pivot_metrics_symbol_tf; Type: INDEX; Schema: core_app_nse; Owner: rathore
--

CREATE INDEX idx_n_bar_pivot_metrics_symbol_tf ON core_app_nse.n_bar_pivot_metrics USING btree (symbol, timeframe, tf_id DESC);


--
-- Name: idx_nbar_sr_instr_tf; Type: INDEX; Schema: core_app_nse; Owner: rathore
--

CREATE INDEX idx_nbar_sr_instr_tf ON core_app_nse.n_bar_support_resistance_metrics USING btree (instrument_id, timeframe, tf_id DESC);


--
-- Name: idx_nbar_sr_symbol_tf; Type: INDEX; Schema: core_app_nse; Owner: rathore
--

CREATE INDEX idx_nbar_sr_symbol_tf ON core_app_nse.n_bar_support_resistance_metrics USING btree (symbol, timeframe, tf_id DESC);


--
-- Name: idx_nse_market_activity_market_report_trade_date; Type: INDEX; Schema: exchange; Owner: rathore
--

CREATE INDEX idx_nse_market_activity_market_report_trade_date ON exchange.nse_market_activity_market_report USING btree (trade_date);


--
-- Name: idx_nse_market_activity_trade_date; Type: INDEX; Schema: exchange; Owner: rathore
--

CREATE INDEX idx_nse_market_activity_trade_date ON exchange.nse_market_activity_market_report USING btree (trade_date);


--
-- Name: idx_instrument_master_symbol; Type: INDEX; Schema: exchange_symbol; Owner: rathore
--

CREATE INDEX idx_instrument_master_symbol ON exchange_symbol.instrument_master USING btree (exchange_code, symbol);


--
-- Name: uq_instrument_master_exchange_instrument_key; Type: INDEX; Schema: exchange_symbol; Owner: rathore
--

CREATE UNIQUE INDEX uq_instrument_master_exchange_instrument_key ON exchange_symbol.instrument_master USING btree (exchange_code, instrument_key);


--
-- Name: uq_instrument_master_exchange_trading_symbol_type; Type: INDEX; Schema: exchange_symbol; Owner: rathore
--

CREATE UNIQUE INDEX uq_instrument_master_exchange_trading_symbol_type ON exchange_symbol.instrument_master USING btree (exchange_code, trading_symbol, instrument_type) WHERE (trading_symbol IS NOT NULL);


--
-- Name: uq_instrument_master_index_source; Type: INDEX; Schema: exchange_symbol; Owner: rathore
--

CREATE UNIQUE INDEX uq_instrument_master_index_source ON exchange_symbol.instrument_master USING btree (source_entity_type, source_entity_id) WHERE (source_entity_type = 'INDEX_MASTER'::text);


--
-- Name: idx_trade_execution_plan_instr_tf_date; Type: INDEX; Schema: market_intelligence; Owner: rathore
--

CREATE INDEX idx_trade_execution_plan_instr_tf_date ON market_intelligence.trade_execution_plan USING btree (instrument_id, timeframe, trade_date);


--
-- Name: idx_trade_execution_plan_status; Type: INDEX; Schema: market_intelligence; Owner: rathore
--

CREATE INDEX idx_trade_execution_plan_status ON market_intelligence.trade_execution_plan USING btree (execution_status);


--
-- Name: idx_trade_execution_plan_trade_date; Type: INDEX; Schema: market_intelligence; Owner: rathore
--

CREATE INDEX idx_trade_execution_plan_trade_date ON market_intelligence.trade_execution_plan USING btree (trade_date);


--
-- Name: idx_trade_outcome_attr_regime_side; Type: INDEX; Schema: market_intelligence; Owner: rathore
--

CREATE INDEX idx_trade_outcome_attr_regime_side ON market_intelligence.trade_outcome_attribution USING btree (market_regime, side_preference);


--
-- Name: idx_trade_outcome_attr_trade_date; Type: INDEX; Schema: market_intelligence; Owner: rathore
--

CREATE INDEX idx_trade_outcome_attr_trade_date ON market_intelligence.trade_outcome_attribution USING btree (trade_date);


--
-- Name: idx_trade_outcome_feedback_updated_at; Type: INDEX; Schema: market_intelligence; Owner: rathore
--

CREATE INDEX idx_trade_outcome_feedback_updated_at ON market_intelligence.trade_outcome_feedback USING btree (updated_at DESC);


--
-- Name: idx_trade_outcomes_instr_tf_date; Type: INDEX; Schema: market_intelligence; Owner: rathore
--

CREATE INDEX idx_trade_outcomes_instr_tf_date ON market_intelligence.trade_outcomes USING btree (instrument_id, timeframe, trade_date);


--
-- Name: idx_trade_outcomes_outcome_status; Type: INDEX; Schema: market_intelligence; Owner: rathore
--

CREATE INDEX idx_trade_outcomes_outcome_status ON market_intelligence.trade_outcomes USING btree (outcome_status);


--
-- Name: idx_trade_outcomes_regime_side; Type: INDEX; Schema: market_intelligence; Owner: rathore
--

CREATE INDEX idx_trade_outcomes_regime_side ON market_intelligence.trade_outcomes USING btree (market_regime, side_preference);


--
-- Name: idx_trade_outcomes_signal_type; Type: INDEX; Schema: market_intelligence; Owner: rathore
--

CREATE INDEX idx_trade_outcomes_signal_type ON market_intelligence.trade_outcomes USING btree (signal_type);


--
-- Name: idx_trade_outcomes_trade_date; Type: INDEX; Schema: market_intelligence; Owner: rathore
--

CREATE INDEX idx_trade_outcomes_trade_date ON market_intelligence.trade_outcomes USING btree (trade_date);


--
-- Name: idx_hour_gap_audit_status; Type: INDEX; Schema: market_nse; Owner: rathore
--

CREATE INDEX idx_hour_gap_audit_status ON market_nse.hour_candle_gap_audit USING btree (repair_status);


--
-- Name: idx_hour_gap_audit_symbol_date; Type: INDEX; Schema: market_nse; Owner: rathore
--

CREATE INDEX idx_hour_gap_audit_symbol_date ON market_nse.hour_candle_gap_audit USING btree (symbol, trade_date);


--
-- Name: idx_hour_gap_audit_trade_date; Type: INDEX; Schema: market_nse; Owner: rathore
--

CREATE INDEX idx_hour_gap_audit_trade_date ON market_nse.hour_candle_gap_audit USING btree (trade_date);


--
-- Name: idx_market_candle_inst_tf_trade_date; Type: INDEX; Schema: market_nse; Owner: rathore
--

CREATE INDEX idx_market_candle_inst_tf_trade_date ON market_nse.market_candle USING btree (instrument_id, timeframe, trade_date, bar_start_ts);


--
-- Name: idx_market_candle_pivot_event_lookup; Type: INDEX; Schema: market_nse; Owner: rathore
--

CREATE INDEX idx_market_candle_pivot_event_lookup ON market_nse.market_candle_pivot USING btree (instrument_id, timeframe, tf_id);


--
-- Name: uq_market_candle_key; Type: INDEX; Schema: market_nse; Owner: rathore
--

CREATE UNIQUE INDEX uq_market_candle_key ON market_nse.market_candle USING btree (instrument_id, timeframe, bar_start_ts);


--
-- Name: uq_market_candle_pivot_event; Type: INDEX; Schema: market_nse; Owner: rathore
--

CREATE UNIQUE INDEX uq_market_candle_pivot_event ON market_nse.market_candle_pivot USING btree (instrument_id, timeframe, bar_start_ts);


--
-- Name: mcx_tick_data_idx_raw_ticks_symbol_ts; Type: INDEX; Schema: mcx_tick_data; Owner: rathore
--

CREATE INDEX mcx_tick_data_idx_raw_ticks_symbol_ts ON mcx_tick_data.raw_ticks USING btree (symbol, ingest_ts DESC);


--
-- Name: idx_engine_run_tracker_lookup; Type: INDEX; Schema: meta_data; Owner: rathore
--

CREATE INDEX idx_engine_run_tracker_lookup ON meta_data.engine_run_tracker USING btree (engine_name, instrument_id, timeframe, trade_date, started_at DESC);


--
-- Name: idx_nse_market_holiday_date; Type: INDEX; Schema: meta_data; Owner: rathore
--

CREATE INDEX idx_nse_market_holiday_date ON meta_data.nse_market_holiday USING btree (trade_date);


--
-- Name: idx_nfo_underlying; Type: INDEX; Schema: nfo_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_nfo_underlying ON nfo_exchange_symbol.instrument_master_derivative USING btree (nse_underlying_instrument_id);


--
-- Name: nfo_tick_data_idx_raw_ticks_symbol_ts; Type: INDEX; Schema: nfo_tick_data; Owner: rathore
--

CREATE INDEX nfo_tick_data_idx_raw_ticks_symbol_ts ON nfo_tick_data.raw_ticks USING btree (symbol, ingest_ts DESC);


--
-- Name: idx_icb_instrument; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_icb_instrument ON nse_exchange_symbol.instrument_chart_bootstrap USING btree (instrument_id);


--
-- Name: idx_im_source_entity; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_im_source_entity ON nse_exchange_symbol.instrument_master USING btree (source_entity_type, source_entity_id);


--
-- Name: idx_im_symbol_upper; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_im_symbol_upper ON nse_exchange_symbol.instrument_master USING btree (upper(symbol));


--
-- Name: idx_im_trading_symbol_upper; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_im_trading_symbol_upper ON nse_exchange_symbol.instrument_master USING btree (upper(trading_symbol));


--
-- Name: idx_ix_bhav_upper; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_ix_bhav_upper ON nse_exchange_symbol.index_master USING btree (upper(index_name_bhav_copy));


--
-- Name: idx_ix_index_name_upper; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_ix_index_name_upper ON nse_exchange_symbol.index_master USING btree (upper(index_name));


--
-- Name: idx_ix_market_activity_upper; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_ix_market_activity_upper ON nse_exchange_symbol.index_master USING btree (upper(index_name_market_activity));


--
-- Name: idx_nse_bootstrap_auto_import; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_nse_bootstrap_auto_import ON nse_exchange_symbol.instrument_chart_bootstrap USING btree (auto_import_enabled);


--
-- Name: idx_nse_bootstrap_rebuild_required; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_nse_bootstrap_rebuild_required ON nse_exchange_symbol.instrument_chart_bootstrap USING btree (rebuild_required);


--
-- Name: idx_nse_bootstrap_status; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_nse_bootstrap_status ON nse_exchange_symbol.instrument_chart_bootstrap USING btree (bootstrap_status, chart_data_status);


--
-- Name: idx_nse_equity_isin; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_nse_equity_isin ON nse_exchange_symbol.instrument_master_equity USING btree (isin);


--
-- Name: idx_nse_equity_token; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_nse_equity_token ON nse_exchange_symbol.instrument_master_equity USING btree (token);


--
-- Name: idx_nse_index_constituent_map_instrument_date; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_nse_index_constituent_map_instrument_date ON nse_exchange_symbol.index_constituent_map USING btree (instrument_id, trade_date);


--
-- Name: idx_nse_index_constituent_map_trade_date; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_nse_index_constituent_map_trade_date ON nse_exchange_symbol.index_constituent_map USING btree (trade_date);


--
-- Name: idx_nse_index_master_active; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_nse_index_master_active ON nse_exchange_symbol.index_master USING btree (is_active);


--
-- Name: idx_nse_instrument_master_symbol; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_nse_instrument_master_symbol ON nse_exchange_symbol.instrument_master USING btree (symbol);


--
-- Name: idx_nse_instrument_master_type; Type: INDEX; Schema: nse_exchange_symbol; Owner: rathore
--

CREATE INDEX idx_nse_instrument_master_type ON nse_exchange_symbol.instrument_master USING btree (instrument_type, asset_class);


--
-- Name: idx_nse_tick_data_raw_ticks_symbol_ts; Type: INDEX; Schema: nse_tick_data; Owner: rathore
--

CREATE INDEX idx_nse_tick_data_raw_ticks_symbol_ts ON nse_tick_data.raw_ticks USING btree (symbol, event_ts);


--
-- Name: idx_nse_tick_data_raw_ticks_token_ts; Type: INDEX; Schema: nse_tick_data; Owner: rathore
--

CREATE INDEX idx_nse_tick_data_raw_ticks_token_ts ON nse_tick_data.raw_ticks USING btree (token, event_ts);


--
-- Name: idx_nse_tick_data_realtime_5m_bar_symbol; Type: INDEX; Schema: nse_tick_data; Owner: rathore
--

CREATE INDEX idx_nse_tick_data_realtime_5m_bar_symbol ON nse_tick_data.realtime_5m_bar USING btree (symbol, bar_start_ts);


--
-- Name: nse_tick_data_idx_raw_ticks_symbol_ts; Type: INDEX; Schema: nse_tick_data; Owner: rathore
--

CREATE INDEX nse_tick_data_idx_raw_ticks_symbol_ts ON nse_tick_data.raw_ticks USING btree (symbol, ingest_ts DESC);


--
-- Name: idx_signals_nse_c2_trade_date; Type: INDEX; Schema: signals_nse; Owner: rathore
--

CREATE INDEX idx_signals_nse_c2_trade_date ON signals_nse.momentum_liquidity USING btree (trade_date, timeframe, sms_score DESC);


--
-- Name: idx_signals_nse_c3_trade_date; Type: INDEX; Schema: signals_nse; Owner: rathore
--

CREATE INDEX idx_signals_nse_c3_trade_date ON signals_nse.volatility_breakout USING btree (trade_date, timeframe, pbps_score DESC);


--
-- Name: idx_signals_nse_c4_trade_date; Type: INDEX; Schema: signals_nse; Owner: rathore
--

CREATE INDEX idx_signals_nse_c4_trade_date ON signals_nse.market_regime USING btree (trade_date, timeframe, tsi_score DESC);


--
-- Name: idx_signals_nse_symbol_signal_trade_date; Type: INDEX; Schema: signals_nse; Owner: rathore
--

CREATE INDEX idx_signals_nse_symbol_signal_trade_date ON signals_nse.symbol_signal USING btree (trade_date, timeframe, tos_score DESC);


--
-- Name: idx_structural_context_symbol_tf; Type: INDEX; Schema: signals_nse; Owner: rathore
--

CREATE INDEX idx_structural_context_symbol_tf ON signals_nse.structural_context USING btree (symbol, timeframe, tf_id DESC);


--
-- Name: idx_structural_context_trade_date; Type: INDEX; Schema: signals_nse; Owner: rathore
--

CREATE INDEX idx_structural_context_trade_date ON signals_nse.structural_context USING btree (trade_date, timeframe);


--
-- Name: idx_chart_csv_eod_inst_tf_bar; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_chart_csv_eod_inst_tf_bar ON staging.chart_csv_eod USING btree (instrument_id, timeframe, bar_start_ts);


--
-- Name: idx_chart_csv_eod_inst_tf_ts; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_chart_csv_eod_inst_tf_ts ON staging.chart_csv_eod USING btree (instrument_id, timeframe, trade_timestamp);


--
-- Name: idx_chart_csv_eod_instrument_timeframe; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_chart_csv_eod_instrument_timeframe ON staging.chart_csv_eod USING btree (instrument_id, timeframe);


--
-- Name: idx_ma_index_name_upper; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_ma_index_name_upper ON staging.nse_market_activity_index_eod USING btree (upper(index_name));


--
-- Name: idx_ma_raw_index_name_upper; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_ma_raw_index_name_upper ON staging.nse_market_activity_index_eod USING btree (upper(raw_index_name));


--
-- Name: idx_nse_api_cache_inst_tf_req; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_nse_api_cache_inst_tf_req ON staging.nse_api_cache USING btree (instrument_id, timeframe, request_from_ts, request_to_ts);


--
-- Name: idx_nse_bhavcopy_file_audit_trade_date; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_nse_bhavcopy_file_audit_trade_date ON staging.nse_bhavcopy_file_audit USING btree (trade_date);


--
-- Name: idx_nse_bhavcopy_security_eod_instrument_id; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_nse_bhavcopy_security_eod_instrument_id ON staging.nse_bhavcopy_security_eod USING btree (instrument_id) WHERE (instrument_id IS NOT NULL);


--
-- Name: idx_nse_hl_daily_levels_trade_date; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_nse_hl_daily_levels_trade_date ON staging.nse_hl_daily_levels USING btree (trade_date);


--
-- Name: idx_nse_pd_index_eod_trade_date; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_nse_pd_index_eod_trade_date ON staging.nse_pd_index_eod USING btree (trade_date);


--
-- Name: idx_nse_pr_index_eod_trade_date; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_nse_pr_index_eod_trade_date ON staging.nse_pr_index_eod USING btree (trade_date);


--
-- Name: idx_pd_security_name_upper; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_pd_security_name_upper ON staging.nse_pd_index_eod USING btree (upper(security_name));


--
-- Name: idx_phase_a_substep_tracker_status; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_phase_a_substep_tracker_status ON staging.phase_a_substep_tracker USING btree (status, updated_at);


--
-- Name: idx_step03_candidate_instrument; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_step03_candidate_instrument ON staging.step03_reconcile_candidate USING btree (instrument_id, run_id);


--
-- Name: idx_step03_candidate_integrity_audit_candidate_required; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_step03_candidate_integrity_audit_candidate_required ON staging.step03_candidate_integrity_audit USING btree (candidate_required, timeframe);


--
-- Name: idx_step03_candidate_integrity_audit_run_id; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_step03_candidate_integrity_audit_run_id ON staging.step03_candidate_integrity_audit USING btree (run_id);


--
-- Name: idx_step03_candidate_run_id; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_step03_candidate_run_id ON staging.step03_reconcile_candidate USING btree (run_id);


--
-- Name: idx_stg_market_candle_raw_ingest; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_stg_market_candle_raw_ingest ON staging.market_candle_raw USING btree (ingested_at);


--
-- Name: idx_stg_market_candle_raw_inst_date; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE INDEX idx_stg_market_candle_raw_inst_date ON staging.market_candle_raw USING btree (instrument_id, timeframe, bar_start_ts);


--
-- Name: uq_broker_chart_api_raw_req; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE UNIQUE INDEX uq_broker_chart_api_raw_req ON staging.broker_chart_api_raw USING btree (instrument_id, timeframe, request_from_ts, request_to_ts, source_name);


--
-- Name: uq_nse_pd_equity; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE UNIQUE INDEX uq_nse_pd_equity ON staging.nse_pd_index_eod USING btree (trade_date, symbol) WHERE (symbol IS NOT NULL);


--
-- Name: uq_nse_pd_index; Type: INDEX; Schema: staging; Owner: rathore
--

CREATE UNIQUE INDEX uq_nse_pd_index ON staging.nse_pd_index_eod USING btree (trade_date, security_name) WHERE (symbol IS NULL);


--
-- Name: instrument_master_derivative instrument_master_derivative_bse_underlying_instrument_id_fkey; Type: FK CONSTRAINT; Schema: bfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bfo_exchange_symbol.instrument_master_derivative
    ADD CONSTRAINT instrument_master_derivative_bse_underlying_instrument_id_fkey FOREIGN KEY (bse_underlying_instrument_id) REFERENCES bse_exchange_symbol.instrument_master(instrument_id) ON DELETE SET NULL;


--
-- Name: instrument_master_derivative instrument_master_derivative_instrument_id_fkey; Type: FK CONSTRAINT; Schema: bfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bfo_exchange_symbol.instrument_master_derivative
    ADD CONSTRAINT instrument_master_derivative_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES bfo_exchange_symbol.instrument_master(instrument_id) ON DELETE CASCADE;


--
-- Name: instrument_all_time_levels instrument_all_time_levels_instrument_id_fkey; Type: FK CONSTRAINT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.instrument_all_time_levels
    ADD CONSTRAINT instrument_all_time_levels_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES bse_exchange_symbol.instrument_master(instrument_id) ON DELETE CASCADE;


--
-- Name: instrument_chart_bootstrap instrument_chart_bootstrap_instrument_id_fkey; Type: FK CONSTRAINT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.instrument_chart_bootstrap
    ADD CONSTRAINT instrument_chart_bootstrap_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES bse_exchange_symbol.instrument_master(instrument_id) ON DELETE CASCADE;


--
-- Name: instrument_master_equity instrument_master_equity_instrument_id_fkey; Type: FK CONSTRAINT; Schema: bse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY bse_exchange_symbol.instrument_master_equity
    ADD CONSTRAINT instrument_master_equity_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES bse_exchange_symbol.instrument_master(instrument_id) ON DELETE CASCADE;


--
-- Name: instrument_master_derivative instrument_master_derivative_instrument_id_fkey; Type: FK CONSTRAINT; Schema: cds_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY cds_exchange_symbol.instrument_master_derivative
    ADD CONSTRAINT instrument_master_derivative_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES cds_exchange_symbol.instrument_master(instrument_id) ON DELETE CASCADE;


--
-- Name: instrument_master_derivative instrument_master_derivative_instrument_id_fkey; Type: FK CONSTRAINT; Schema: mcx_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY mcx_exchange_symbol.instrument_master_derivative
    ADD CONSTRAINT instrument_master_derivative_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES mcx_exchange_symbol.instrument_master(instrument_id) ON DELETE CASCADE;


--
-- Name: instrument_master_derivative instrument_master_derivative_instrument_id_fkey; Type: FK CONSTRAINT; Schema: nfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nfo_exchange_symbol.instrument_master_derivative
    ADD CONSTRAINT instrument_master_derivative_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES nfo_exchange_symbol.instrument_master(instrument_id) ON DELETE CASCADE;


--
-- Name: instrument_master_derivative instrument_master_derivative_nse_underlying_instrument_id_fkey; Type: FK CONSTRAINT; Schema: nfo_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nfo_exchange_symbol.instrument_master_derivative
    ADD CONSTRAINT instrument_master_derivative_nse_underlying_instrument_id_fkey FOREIGN KEY (nse_underlying_instrument_id) REFERENCES nse_exchange_symbol.instrument_master(instrument_id) ON DELETE SET NULL;


--
-- Name: index_constituent_map index_constituent_map_index_id_fkey; Type: FK CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.index_constituent_map
    ADD CONSTRAINT index_constituent_map_index_id_fkey FOREIGN KEY (index_id) REFERENCES nse_exchange_symbol.index_master(index_id) ON DELETE CASCADE;


--
-- Name: index_constituent_map index_constituent_map_instrument_id_fkey; Type: FK CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.index_constituent_map
    ADD CONSTRAINT index_constituent_map_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES nse_exchange_symbol.instrument_master(instrument_id) ON DELETE CASCADE;


--
-- Name: instrument_all_time_levels instrument_all_time_levels_instrument_id_fkey; Type: FK CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.instrument_all_time_levels
    ADD CONSTRAINT instrument_all_time_levels_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES nse_exchange_symbol.instrument_master(instrument_id) ON DELETE CASCADE;


--
-- Name: instrument_chart_bootstrap instrument_chart_bootstrap_instrument_id_fkey; Type: FK CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.instrument_chart_bootstrap
    ADD CONSTRAINT instrument_chart_bootstrap_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES nse_exchange_symbol.instrument_master(instrument_id) ON DELETE CASCADE;


--
-- Name: instrument_master_equity instrument_master_equity_instrument_id_fkey; Type: FK CONSTRAINT; Schema: nse_exchange_symbol; Owner: rathore
--

ALTER TABLE ONLY nse_exchange_symbol.instrument_master_equity
    ADD CONSTRAINT instrument_master_equity_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES nse_exchange_symbol.instrument_master(instrument_id) ON DELETE CASCADE;


--
-- Name: phase_a_step_run_audit phase_a_step_run_audit_run_id_fkey; Type: FK CONSTRAINT; Schema: staging; Owner: rathore
--

ALTER TABLE ONLY staging.phase_a_step_run_audit
    ADD CONSTRAINT phase_a_step_run_audit_run_id_fkey FOREIGN KEY (run_id) REFERENCES staging.phase_a_run_audit(run_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict iqNqmBP406CICgKrXbgK7ky3L5E6wGsmebYf7jguEYP305WTCPR5eeXiz5TIADx

