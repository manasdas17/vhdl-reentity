
package pack1 is

component test1 is
	port (
		a: in std_logic;
		b: out std_logic_vector(1 downto 0)
	);
end component;

library blalalalo.ieee;
use hahaha.ieee;

--tatata tata


component test2 is
	generic(
		number: integer:=8);
	port (
		--tititi
		c: in std_logic;
		d: out std_logic_vector(3 downto 0)
	); --foo bar
end component;

architecture foo of test2 is
begin
end

--tatata

component test3 is
	port(
		a: in std_logic;
		b: out std_logic
	);
end component;

architecture foo of test3 is
	
	component test1 is
		port (
			a: in std_logic;
			b: out std_logic_vector(1 downto 0)
		);
	end component;

begin

TEST1_INSTANCE: test1 port map (lol, blol);

end architecture;

end package;
