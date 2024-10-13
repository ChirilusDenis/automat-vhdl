library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Automat_tb is
end;

architecture bench of Automat_tb is

  component Automat
      PORT(I : in std_logic_vector(4 downto 0);
           O : out std_logic_vector(5 downto 0);
           clk, reset : in std_logic
           ); 
  end component;

  signal I: std_logic_vector(4 downto 0);
  signal clk, reset: std_logic := '0';
  signal O : std_logic_vector (5 downto 0);
  constant clock_period : time := 20 ns;

begin

  uut: Automat port map ( I          => I,
                          O          => O,
                          clk        => clk,
                          reset      => reset );
 
clock_process :process
begin
clk <= '0';
wait for clock_period/2;
clk <= '1';
wait for clock_period/2;
end process;
 
stim_proc: process
begin
wait for 30 ns;
reset <= '1'; -- reset
wait for 40 ns;
reset <= '0';

wait for 40 ns;
I <= "01000"; -- +5
wait for 40 ns; -- produs
I <= "00010";
wait for 40 ns;
I <= "00001"; -- rest
wait for 40 ns;
I <= "00000";

wait for 80 ns;
I <= "10000"; -- + 10
wait for 40 ns;
I <= "00010"; -- produs
wait for 40 ns;
I <= "00000";
wait for 40 ns;
I <= "00010"; -- produs
wait for 40 ns;
I <= "00000";
wait for 40 ns;
I <= "00001"; -- rest
wait for 40 ns;
I <= "00000";

wait for 80 ns;
I <= "01000"; -- +5
wait for 40 ns;
I <= "00100"; -- +1
wait for 40 ns;
I <= "00010"; -- produs
wait for 40 ns;
I <= "00001"; -- rest
wait for 40 ns;
I <= "00000";

wait for 80 ns;
I <= "10000"; -- +10
wait for 40 ns;
I <= "00001"; -- rest
wait for 40 ns;
I <= "00000";

wait for 80 ns;
I <= "10000"; -- + 10
wait for 40 ns;
I <= "01000"; -- + 5
wait for 40 ns;
I <= "00100"; -- + 1
wait for 40 ns;
I <= "00010"; -- produs
wait for 40 ns;
I <= "00001"; -- rest;
wait for 40 ns;
I <= "00000";

wait for 80 ns;
I <= "10000"; -- + 10
wait for 40 ns;
I <= "01000"; -- + 5
wait for 40 ns;
I <= "00001"; -- rest
wait for 40 ns;
I <= "00000";

wait for 80 ns;
I <= "00100"; -- +1
wait for 40 ns;
I <= "00100"; -- +1
wait for 40 ns;
I <= "00100"; -- +1
wait for 40 ns;
I <= "00010"; -- produs
wait for 40 ns;
I <= "00000";

wait for 80 ns;
I <= "01000"; -- +5
wait for 40 ns;
I <= "00010"; -- produs
wait for 40 ns;
I <= "01000"; -- +5
wait for 40 ns;
I <= "00010"; -- produs
wait for 40 ns;
I <= "00001"; -- rest
wait for 40 ns;
I <= "00000";

wait;
end process;
 
END;
