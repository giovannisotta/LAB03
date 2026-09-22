library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk_div is
    port (
        clk_in  : in  std_logic;   -- clock da placa (ex: 50 MHz)
        reset   : in  std_logic;   -- opcional, ativo em alto
        clk_out : out std_logic    -- clock lento (ex: ~0.5 Hz = 2s)
    );
end entity clk_div;

architecture rtl of clk_div is
    constant N : integer := 25_000_000; -- ajuste conforme seu clock/período desejado
    signal counter : integer range 0 to N-1 := 0;
    signal clk_reg : std_logic := '0';
begin
    process(clk_in, reset)
    begin
        if reset = '1' then
            counter <= 0;
            clk_reg  <= '0';
        elsif rising_edge(clk_in) then
            if counter = N-1 then
                counter <= 0;
                clk_reg  <= not clk_reg;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_reg;
end architecture rtl;