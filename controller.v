module parking_management(
    input wire clk,  // clock signal
    input wire rst,  // reset signal
    input wire entered_car,  // car entering the parking lot
    input wire entered_car_uni_is,  // is the entering car a university car?
    input wire exited_car,  // car exiting the parking lot
    input wire exited_car_uni_is,  // is the exiting car a university car?

    output reg [8:0] car_parked_u,  // number of university cars parked
    output reg [8:0] car_parked_f,  // number of free cars parked
    output reg [8:0] space_vacated_uni,  // vacant university spaces
    output reg [8:0] space_vacated_f,  // vacant free spaces
    output reg space_vacated_is_uni,  // is there a vacant university space?
    output reg space_vacated_is  // is there a vacant free space?
);

    // parameters
    parameter TOTAL_UNI_SPACES = 500;
    parameter TOTAL_FREE_SPACES_MORNING = 200;
    parameter TOTAL_SPACES = 700;
    parameter CLOCKS_PER_HOUR = 100;

    reg [31:0] clock_counter;  // counter to count clock cycles
    reg [4:0] hour;  // current hour (0-23)
    reg [8:0] free_capacity;

    // increment hour based on clock cycles
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clock_counter <= 0;
            hour <= 8;  // starting hour is 8 AM
        end else begin
            if (clock_counter == CLOCKS_PER_HOUR - 1) begin
                clock_counter <= 0;
                if (hour < 23) begin
                    hour <= hour + 1;
                end else begin
                    hour <= 0;  // reset to midnight after 23:00
                end
            end else begin
                clock_counter <= clock_counter + 1;
            end
        end
    end
endmodule
