----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/21/2023 02:54:48 PM
-- Design Name: 
-- Module Name: Automat - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity Automat is
    PORT(I : in std_logic_vector(4 downto 0);--+10, +5, +1, produs, rest 
         O : out std_logic_vector(5 downto 0);--accept, return tot, refuza curent, out5, out1, outprodus;
         clk, reset : in std_logic
         ); 
end Automat;

architecture Behavioral of Automat is
    type state_type is (s0, s1, s2, s3 ,s4, s5, s6, s7, s8, s9,
                        s10, s11, s12, s13, s14, s15, s00, s01,
                        s02, s03, s04, s05, s06, s07, s08, s09,
                        s010, s011, s012, s013, s014, s015, r1,
                        r2, r3, r4, r5, r6, r7, r8, r9, r10);
    signal state : state_type := s0;
    signal next_state : state_type := s0;
    signal num1 : integer := 0;
    signal num5 : integer := 0;
    signal waiting : integer := 0;

begin

present_state_logic : process (state, clk, I)
    begin
 if (reset = '1') then 
        state <= s0;
--        next_state <= s0;
        waiting <= 0;
    else 
        if (rising_edge(clk)) then
            state <= next_state;
            case state is
                when s0 =>
                    case I is
                        when "00100" => next_state <= s1;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                        when "01000" => next_state <= s5;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                        when "10000" => next_state <= s10;
                                        O <= "000000";
                        when others => next_state <= s0;
                                       O <= "000000";
                    end case;
                when s1 =>
                    case I is
                        when "00001" => O <= "000010"; -- rest 1
                                        num1 <= num1 - 1;
                                        next_state <= s0;
                                        
                        when "00100" => next_state <= s2;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s6;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => next_state <= s11;
                                         O <= "000000";
                        
                        when others => next_state <= s1;
                                       O <= "000000";
                        
                    end case;
                when s2 =>
                    case I is
                        when "00001" => O <= "000010"; -- rest 1
                                        num1 <= num1 - 1;
                                        next_state <= r1;
                                        
                        when "00100" => next_state <= s3;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s7;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => next_state <= s12;
                                        O <= "000000";
                        
                        when others => next_state <= s2;
                                       O <= "000000";
                        
                    end case;
                when s3 =>
                    case I is
                        when "00001" => O <= "000010"; -- rest 1
                                        num1 <= num1 - 1;
                                        next_state <= r2;
                                        
                        when "00100" => next_state <= s4;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s8;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => next_state <= s13;
                                        O <= "000000";
                        
                        when others => next_state <= s3;
                                       O <= "000000";
                        
                    end case;
                when s4 =>
                    case I is
                        when "00001" => O <= "000010"; -- rest 1
                                        num1 <= num1 - 1;
                                        next_state <= r3;
                                        
                        when "00100" => next_state <= s5;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s9;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => next_state <= s14;
                                        O <= "000000";
                        
                        when others => next_state <= s4;
                                       O <= "000000";
                        
                    end case;
                when s5 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 1
                                        num5 <= num5 - 1;
                                        next_state <= s0;
                        when "00010" => O <= "100001"; -- accept bani + produs
                                        next_state <= s00;
                        when "00100" => next_state <= s6;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                        when "01000" => next_state <= s10;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                        when "10000" => next_state <= s11;
                                        O <= "000000";
                        when others => next_state <= s5;
                                       O <= "000000";
                    end case;
                when s6 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r1;
                                        
                        when "00010" => if (num1 >= 1) then
                                            O <= "100001"; -- accept bani + produs
                                            next_state <= s01;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => next_state <= s7;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s11;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => O <= "001000";  -- refuza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s6;
                                        
                        when others => next_state <= s6;
                                       O <= "000000";
                    end case;
                when s7 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r2;
                                        
                        when "00010" => if (num1 >= 2) then
                                            O <= "100001"; -- accept bani + produs
                                            next_state <= s02;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => next_state <= s8;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s12;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s7;
                                        
                        when others => next_state <= s7;
                                       O <= "000000";
                        
                    end case;
                when s8 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r3;
                                        
                        when "00010" => if (num1 >= 3) then
                                            O <= "100001"; -- accept + produs
                                            next_state <= s03;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if; 
                                        
                        when "00100" => next_state <= s9;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s13;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s8;
                                        
                        when others => next_state <= s8;
                                       O <= "000000";
                        
                    end case;
                when s9 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r4;
                                        
                        when "00010" => if (num1 >= 4) then
                                            O <= "100001"; -- acept + produs
                                            next_state <= s04;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if; 
                                        
                        when "00100" => next_state <= s10;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s14;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => O <= "001000"; -- refuza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s9;
                                        O <= "000000";
                                        
                        when others => next_state <= s9;
                                       O <= "000000";
                        
                    end case;
                when s10 =>
                    case I is
                        when "00001" => if (num5 >= 1 and num1 >= 4) then
                                            O <= "000100"; -- rest 5
                                            num5 <= num5 - 1;
                                            next_state <= r4;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            next_state <= s0;
                                        end if;
                                        
                        when "00010" => if (num5 >= 1) then
                                            O <= "100001"; -- accept + produs
                                            next_state <= s05;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if; 
                                        
                        when "00100" => next_state <= s11;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s15;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s10;
                                        
                        when others => next_state <= s10;
                                       O <= "000000";
                        
                    end case;
                when s11 =>
                    case I is
                        when "00001" => if (num5 >= 2) then
                                            O <= "000100"; -- rest 5
                                            num5 <= num5 - 1;
                                            next_state <= r5;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            next_state <= s0;
                                        end if;
                                        
                        when "00010" => if (num1 >= 1 and num5 >= 1) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s06;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => next_state <= s12;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s11;
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s11;
                                        O <= "000000";
                                        
                        when others => next_state <= s11;
                                       O <= "000000";
                        
                    end case;
                when s12 =>
                    case I is
                        when "00001" => if (num5 >= 2 and num1 >= 1) then
                                            O <= "000100"; -- rest 5
                                            num5 <= num5 - 1;
                                            next_state <= r6;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            next_state <= s0;
                                        end if;
                                        
                        when "00010" => if (num1 >= 2 and num5 >= 1) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s07;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if; 
                                        
                        when "00100" => next_state <= s13;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s12;
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s12;
                                        
                        when others => next_state <= s12;
                                       O <= "000000";
                        
                    end case;
                when s13 =>
                    case I is
                        when "00001" => if (num5 >= 2 and num1 >= 2) then
                                            O <= "000100"; -- rest 5
                                            num5 <= num5 - 1;
                                            next_state <= r7;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            next_state <= s0;
                                        end if;
                                        
                        when "00010" => if (num1 >= 3 and num5 >= 1) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s08;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if; 
                                        
                        when "00100" => next_state <= s14;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s13;
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s13;
                                        
                        when others => next_state <= s13;
                                       O <= "000000";
                        
                    end case;
                when s14 =>
                    case I is
                        when "00001" => if (num5 >=2 and num1 >= 3) then
                                            O <= "000100"; -- rest 5
                                            num5 <= num5 - 1;
                                            next_state <= r8;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            next_state <= s0;
                                        end if;
                                        
                        when "00010" => if (num1 >= 4 and num5 >= 1) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s09;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if; 
                                        
                        when "00100" => next_state <= s15;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s14;
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s14;
                                        
                        when others => next_state <= s14;
                                       O <= "000000";
                        
                    end case;
                when s15 =>
                    case I is
                        when "00001" => if (num5 >= 2 and num1 >= 4) then
                                            O <= "000100"; -- rest 5
                                            num5 <= num5 - 1;
                                            next_state <= r9;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            next_state <= s0;
                                        end if;
                                        
                        when "00010" => if (num5 >= 2) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s010;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if; 
                                        
                        when "00100" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s15;
                                        
                        when "01000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s15;
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s15;
                                        
                        when others => next_state <= s15;
                                       O <= "000000";
                        
                    end case;
                when s00 =>
                    case I is
                        when "00100" => next_state <= s01;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        waiting <= 0;
                                        
                        when "01000" => next_state <= s05;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        waiting <= 0;
                                        
                        when "10000" => next_state <= s010;
                                        O <= "000000";
                                        waiting <= 0;
                                        
                        when others => if (waiting > 5) then
                                            waiting <= 0;
                                            next_state <= s0;
                                       else
                                            waiting <= waiting + 1;
                                            next_state <= s00;
                                            O <= "000000";
                                       end if;
                                       
                    end case;
                when s01 =>
                    case I is
                        when "00001" => O <= "000010"; -- rest 1
                                        num1 <= num1 - 1;
                                        next_state <= s0;
                                        
                        when "00100" => next_state <= s02;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s06;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => next_state <= s011;
                                        O <= "000000";
                        
                        when others => next_state <= s01;
                                       O <= "000000";
                        
                    end case;
                when s02 =>
                    case I is
                        when "00001" => O <= "000010"; -- rest 1
                                        num1 <= num1 - 1;
                                        next_state <= r1;
                                        O <= "000000";
                                        
                        when "00100" => next_state <= s03;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s07;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => next_state <= s012;
                                        O <= "000000";
                        
                        when others => next_state <= s02;
                                       O <= "000000";
                        
                    end case;
                when s03 =>
                    case I is
                        when "00001" => O <= "000010"; -- rest 1
                                        num1 <= num1 - 1;
                                        next_state <= r2;
                                        
                        when "00100" => next_state <= s04;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s08;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => next_state <= s013;
                                        O <= "000000";
                        
                        when others => next_state <= s03;
                                       O <= "000000";
                        
                    end case;
                when s04 =>
                    case I is
                        when "00001" => O <= "000010"; -- rest 1
                                        num1 <= num1 - 1;
                                        next_state <= r3;
                                        
                        when "00100" => next_state <= s05;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s09;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => next_state <= s014;
                                        O <= "000000";
                        
                        when others => next_state <= s04;
                                       O <= "000000";
                        
                    end case;
                when s05 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= s0;
                                        
                        when "00010" => O <= "100001"; -- accept + produs
                                        next_state <= s00;
                                        
                        when "00100" => next_state <= s06;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s010;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => next_state <= s015;
                                        O <= "000000";
                        
                        when others => next_state <= s05;
                                       O <= "000000";
                        
                    end case;
                when s06 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r1;
                                        
                        when "00010" => if (num1 >= 1) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s01;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => next_state <= s07;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s011;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s06;
                                        
                        when others => next_state <= s06;
                                       O <= "000000";
                        
                    end case;
                when s07 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r2;
                                        
                        when "00010" => if (num1 >= 2) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s02;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => next_state <= s08;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s012;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s07;
                                        
                        when others => next_state <= s07;
                                       O <= "000000";
                        
                    end case;
                when s08 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r3;
                                        
                        when "00010" => if (num1 >= 3) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s03;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => next_state <= s09;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s013;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s08;
                                        
                        when others => next_state <= s08;
                                       O <= "000000";
                        
                    end case;
                when s09 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r4;
                                        
                        when "00010" => if (num1 >= 4) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s04;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => next_state <= s010;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s014;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s09;
                                        
                        when others => next_state <= s09;
                                       O <= "000000";
                        
                    end case;
                when s010 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r5;
                                        
                        when "00010" => if (num5 >= 1) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s05;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => next_state <= s011;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => next_state <= s015;
                                        num5 <= num5 + 1;
                                        O <= "000000";
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s010;
                                        
                        when others => next_state <= s010;
                                       O <= "000000";
                        
                    end case;
                when s011 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r6;
                                        
                        when "00010" => if (num1 >= 1 and num5 >= 1) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s06;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => next_state <= s012;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s011;
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s011;
                                        
                        when others => next_state <= s011;
                                       O <= "000000";
                        
                    end case;
                when s012 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r7;
                                        
                        when "00010" => if (num1 >= 2 and num5 >= 1) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s07;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => next_state <= s013;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s012;
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s012;
                                        
                        when others => next_state <= s012;
                                       O <= "000000";
                        
                    end case;
                when s013 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r8;
                                        
                        when "00010" => if (num1 >= 3 and num5 >= 1) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s08;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => next_state <= s014;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s013;
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s013;
                                        
                        when others => next_state <= s013;
                                       O <= "000000";
                        
                    end case;
                when s014 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r9;
                                        
                        when "00010" => if (num1 >= 4 and num5 >= 1) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s09;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => next_state <= s015;
                                        num1 <= num1 + 1;
                                        O <= "000000";
                                        
                        when "01000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s014;
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s014;
                                        
                        when others => next_state <= s014;
                                       O <= "000000";
                        
                    end case;
                when s015 =>
                    case I is
                        when "00001" => O <= "000100"; -- rest 5
                                        num5 <= num5 - 1;
                                        next_state <= r10;
                                        
                        when "00010" => if (num5 >= 2) then
                                            O <= "100001"; -- acccept + produs
                                            next_state <= s010;
                                        else
                                            O <= "010000"; -- returneaza tot
                                            report "Rest insuficient";
                                            next_state <= s0;
                                        end if;
                                        
                        when "00100" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s015;
                                        
                        when "01000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s015;
                                        
                        when "10000" => O <= "001000"; -- returneaza curent
                                        report "Sold peste 15 lei";
                                        next_state <= s015;
                                        
                        when others => next_state <= s015;
                                       O <= "000000";
                        
                    end case;
                when r1 => O <= "000010"; -- rest 1
                           num1 <= num1 - 1;
                           next_state <= s0;
                           
                when r2 => O <= "000010"; -- rest 1
                           num1 <= num1 - 1;
                           next_state <= r1;
                           
                when r3 => O <= "000010"; -- rest 1
                           num1 <= num1 - 1;
                           next_state <= r2;
                           
                when r4 => O <= "000010"; -- rest 1
                           num1 <= num1 - 1;
                           next_state <= r3;
                           
                when r5 => O <= "000100"; -- rest 5
                           num5 <= num5 - 1;
                           next_state <= s0;
                           
                when r6 => O <= "000100"; -- rest 5
                           num5 <= num5 - 1;
                           next_state <= r1;
                           
                when r7 => O <= "000100"; -- rest 5
                           num5 <= num5 - 1;
                           next_state <= r2;
                           
                when r8 => O <= "000100"; -- rest 5
                           num5 <= num5 - 1;
                           next_state <= r3;
                           
                when r9 => O <= "000100"; -- rest 5
                           num5 <= num5 - 1;
                           next_state <= r4;
                           
                when r10 => O <= "000100"; -- rest 5
                            num5 <= num5 - 1;
                            next_state <= r5;
                            
                when others => NULL ;
           end case;
        end if;
    end if;
end process present_state_logic;
end Behavioral;
