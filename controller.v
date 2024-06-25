module parking_controller(
    input wire clk,  // clock signal
    input wire rst,  // reset signal
    input wire car_entered,  // car entering the parking lot
    input wire is_uni_car_entered,  // is the entering car a university car?
    input wire car_exited,  // car exiting the parking lot
    input wire is_uni_car_exited,  // is the exiting car a university car?

    output reg [8:0] uni_parked_car,  // number of university cars parked
    output reg [8:0] f_parked_car,  // number of free cars parked
    output reg [8:0] uni_vacated_space,  // vacant university spaces
    output reg [8:0] f_vacated_space,  // vacant free spaces
    output reg is_uni_vacated_space,  // is there a vacant university space?
    output reg is_vacated_space  // is there a vacant free space?
);

    // parameters
    parameter TOTAL_UNI_SPACES = 500;
    parameter TOTAL_FREE_SPACES_MORNING = 200;
    parameter TOTAL_SPACES = 700;
    parameter CLOCKS_PER_HOUR = 10;

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

    // calculate free capacity based on the current hour
    always @(hour or rst) begin
        if (rst) begin
            free_capacity <= TOTAL_FREE_SPACES_MORNING;
        end else begin
            case (hour)
                5'd8: free_capacity <= 200;
                5'd9: free_capacity <= 200;
                5'd10: free_capacity <= 200;
                5'd11: free_capacity <= 200;
                5'd12: free_capacity <= 200;
                5'd13: free_capacity <= 250;
                5'd14: free_capacity <= 300;
                5'd15: free_capacity <= 350;
                5'd16: free_capacity <= 500;
                default: free_capacity <= 500;
            endcase
        end
    end

    // update parking counts based on car entry and exit
    always @(posedge rst or posedge car_entered or posedge car_exited) begin
        if (rst) begin
            uni_parked_car <= 0;
            f_parked_car <= 0;
        end else begin
            // car entry
            if (car_entered) begin
                if (is_uni_car_entered) begin
                    if (uni_parked_car < TOTAL_SPACES - free_capacity) begin
                        uni_parked_car <= uni_parked_car + 1;
                    end
                end else begin
                    if (f_parked_car < free_capacity) begin
                        f_parked_car <= f_parked_car + 1;
                    end
                end
            end

            // car exit
            if (car_exited) begin
                if (is_uni_car_exited) begin
                    if (uni_parked_car > 0) begin
                        uni_parked_car <= uni_parked_car - 1;
                    end
                end else begin
                    if (f_parked_car > 0) begin
                        f_parked_car <= f_parked_car - 1;
                    end
                end
            end
        end
    end

    // calculate vacant spaces and availability
    always @* begin
        uni_vacated_space = TOTAL_SPACES - free_capacity - uni_parked_car;
        f_vacated_space = free_capacity - f_parked_car;
        is_uni_vacated_space = (uni_vacated_space > 0);
        is_vacated_space = (f_vacated_space > 0);
    end
endmodule
