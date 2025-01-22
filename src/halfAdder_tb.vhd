--+----------------------------------------------------------------------------
--| DESCRIPTION: Testbench for halfAdder.vhd
--|
--| NAMING CONVENSIONS :
--|
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    w_<signal name>          = top level wiring signal
--+----------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  
-- entity should match what we are testing, with _tb
entity halfAdder_tb is
-- no input/output because it's a self-contained testbench 
end halfAdder_tb;

architecture test_bench of halfAdder_tb is 
	
  -- declare the component of your top-level design unit under test (UUT)
  -- this must exactly match entity declaration of the thing you are testing
  component halfAdder is
	port(
      i_A     : in  std_logic; -- 1-bit input port
      i_B     : in  std_logic; 
      o_S     : out std_logic;  -- 1-bit output port (NOTE: NO semicolon on LAST port only!)	    
      o_Cout  : out std_logic  -- Carry port
    ); -- the semicolon is here instead
  end component;

  
  -- declare signals needed to stimulate the UUT inputs
  signal w_sw1 : std_logic := '0';
  signal w_sw0 : std_logic := '0';
  
  -- also need signals for the outputs of the UUT
  signal w_led1 : std_logic := '0';
  signal w_led0 : std_logic := '0';


  
begin
	-- PORT MAPS ----------------------------------------

	-- map ports for any component instances (port mapping is like wiring hardware)
	halfAdder_inst : halfAdder port map (
		i_A     => w_sw1, -- notice comma (not a semicolon)
		i_B     => w_sw0,
		o_S     => w_led0, -- no comma on LAST one
		o_Cout  => w_led1-- TODO:  map Cout 
	);


	-- PROCESSES ----------------------------------------
	
-- Test Plan Process --------------------------------
  test_process : process
  begin

    w_sw1 <= '0'; w_sw0 <= '0'; wait for 10 ns;
      assert w_led0 = '0' report "bad sum" severity error;
      assert w_led1 = '0' report "bad carry" severity error;
    w_sw1 <= '0'; w_sw0 <= '1'; wait for 10 ns;
      assert w_led0 = '1' report "bad sum" severity error;
      assert w_led1 = '0' report "bad carry" severity error;
    w_sw1 <= '1'; w_sw0 <= '0'; wait for 10 ns;
      assert w_led0 = '1' report "bad sum" severity error;
      assert w_led1 = '0' report "bad carry" severity error;
    w_sw1 <= '1'; w_sw0 <= '1'; wait for 10 ns;             
      assert w_led0 = '1' report "bad sum" severity error;  
      assert w_led1 = '0' report "bad carry" severity error;

    wait; -- wait forever
  end process;
	-----------------------------------------------------	
	
end test_bench;
