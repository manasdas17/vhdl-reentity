entity test3 is
	port(
		a: in std_logic;
		b: out std_logic
	);
end entity;

architecture foo of test3 is
	
	component test1 is
		port (
		a: in std_logic;
		b: out std_logic_vector(1 downto 0);
		c: out std_logic
		HAHAHAHAHA
	);
end component;

begin

TEST1_INSTANCE: test1 port map (lol, blol);

end architecture;

