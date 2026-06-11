--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : jeubazzertest.vhw
-- /___/   /\     Timestamp : Thu Apr 23 09:32:33 2026
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: jeubazzertest
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY jeubazzertest IS
END jeubazzertest;

ARCHITECTURE testbench_arch OF jeubazzertest IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT buzzer_jeu
        PORT (
            B1 : In std_logic;
            B2 : In std_logic;
            B3 : In std_logic;
            RST : In std_logic;
            L1 : Out std_logic;
            L2 : Out std_logic;
            L3 : Out std_logic
        );
    END COMPONENT;

    SIGNAL B1 : std_logic := '0';
    SIGNAL B2 : std_logic := '0';
    SIGNAL B3 : std_logic := '0';
    SIGNAL RST : std_logic := '0';
    SIGNAL L1 : std_logic := '0';
    SIGNAL L2 : std_logic := '0';
    SIGNAL L3 : std_logic := '0';

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ns;

    BEGIN
        UUT : buzzer_jeu
        PORT MAP (
            B1 => B1,
            B2 => B2,
            B3 => B3,
            RST => RST,
            L1 => L1,
            L2 => L2,
            L3 => L3
        );

        PROCESS    -- clock process for B1
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                B1 <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                B1 <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            BEGIN
                -- -------------  Current Time:  185ns
                WAIT FOR 185 ns;
                RST <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  385ns
                WAIT FOR 200 ns;
                B2 <= '1';
                RST <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  585ns
                WAIT FOR 200 ns;
                B2 <= '0';
                B3 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  785ns
                WAIT FOR 200 ns;
                B3 <= '0';
                -- -------------------------------------
                WAIT FOR 415 ns;

            END PROCESS;

    END testbench_arch;

