library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fib_fsmd is
  port(
    clk : in std_logic;
    rst : in std_logic;
    
    go : in std_logic;
    n : in std_logic_vector(7 downto 0);
    
    done : out std_logic;
    result : out std_logic_vector(7 downto 0)
    
  );
end entity fib_fsmd;

architecture RTL of fib_fsmd is
  type t_state is (init, incr_xyi, found_fib);
  signal state: t_state := init;
  signal next_state: t_state;
  
  signal i, next_i, x, next_x, y, next_y, n_reg : unsigned(7 downto 0);
begin
  
  process(clk, rst)
  begin
    if (rst = '1') then
      state <= init;                
    elsif(rising_edge(clk)) then
      state <= next_state;
      y <= next_y;
      x <= next_x;
      i <= next_i;
    end if;
  end process;
  
  process(state, go, n_reg, i)
  begin
    next_state <= state;
    done <= '0';
    
    case state is
    when init =>
      if (go = '1' and n_reg <= to_unsigned(2, n_reg'length)) then
        next_state <= found_fib;
      elsif (go = '1') then
        next_state <= incr_xyi;
      end if;
      n_reg <= unsigned(n);
      next_i <= to_unsigned(3, i'length);
      next_x <= to_unsigned(1, i'length);
      next_y <= to_unsigned(1, i'length);
    when incr_xyi =>
      if (i >= n_reg) then
        next_state <= found_fib;
      end if;
      next_i <= i + to_unsigned(1, i'length);
      next_x <= y;
      next_y <= y + x;
    when found_fib =>
      if (go = '0') then
        next_state <= init;
      end if;
      result <= std_logic_vector(y);
      done <= '1';
    end case;
  end process;


end architecture RTL;
