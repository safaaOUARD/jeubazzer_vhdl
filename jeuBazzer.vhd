library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity buzzer_jeu is
    Port (
        B1   : in  STD_LOGIC;   -- bouton joueur 1
        B2   : in  STD_LOGIC;   -- bouton joueur 2
        B3   : in  STD_LOGIC;   -- bouton joueur 3
        RST  : in  STD_LOGIC;   -- reset animateur (actif haut)
        L1   : out STD_LOGIC;   -- lampe joueur 1
        L2   : out STD_LOGIC;   -- lampe joueur 2
        L3   : out STD_LOGIC    -- lampe joueur 3
    );
end buzzer_jeu;

architecture Behavioral of buzzer_jeu is

    signal Q1, Q2, Q3 : STD_LOGIC := '0';  -- états mémorisés (SR-Latch)
    signal LOCK        : STD_LOGIC;          -- signal de blocage global

begin

    -- Signal LOCK : actif dès qu'un joueur a déjà appuyé
    LOCK <= Q1 OR Q2 OR Q3;

    -- Processus SR-Latch joueur 1
    -- S = B1 (si personne n'a encore appuyé), R = RST
    process(B1, RST)
    begin
        if RST = '1' then
            Q1 <= '0';
        elsif B1 = '1' and LOCK = '0' then
            Q1 <= '1';
        end if;
    end process;

    -- Processus SR-Latch joueur 2
    process(B2, RST)
    begin
        if RST = '1' then
            Q2 <= '0';
        elsif B2 = '1' and LOCK = '0' then
            Q2 <= '1';
        end if;
    end process;

    -- Processus SR-Latch joueur 3
    process(B3, RST)
    begin
        if RST = '1' then
            Q3 <= '0';
        elsif B3 = '1' and LOCK = '0' then
            Q3 <= '1';
        end if;
    end process;

    -- Affectations sorties lampes
    L1 <= Q1;
    L2 <= Q2;
    L3 <= Q3;

end Behavioral;