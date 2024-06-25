library verilog;
use verilog.vl_types.all;
entity parking_controller is
    generic(
        TOTAL_UNI_SPACES: integer := 500;
        TOTAL_FREE_SPACES_MORNING: integer := 200;
        TOTAL_SPACES    : integer := 700;
        CLOCKS_PER_HOUR : integer := 10
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        car_entered     : in     vl_logic;
        is_uni_car_entered: in     vl_logic;
        car_exited      : in     vl_logic;
        is_uni_car_exited: in     vl_logic;
        uni_parked_car  : out    vl_logic_vector(8 downto 0);
        f_parked_car    : out    vl_logic_vector(8 downto 0);
        uni_vacated_space: out    vl_logic_vector(8 downto 0);
        f_vacated_space : out    vl_logic_vector(8 downto 0);
        is_uni_vacated_space: out    vl_logic;
        is_vacated_space: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TOTAL_UNI_SPACES : constant is 1;
    attribute mti_svvh_generic_type of TOTAL_FREE_SPACES_MORNING : constant is 1;
    attribute mti_svvh_generic_type of TOTAL_SPACES : constant is 1;
    attribute mti_svvh_generic_type of CLOCKS_PER_HOUR : constant is 1;
end parking_controller;
