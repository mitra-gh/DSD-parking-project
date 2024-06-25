`timescale 1ns / 1ps

module tb_parking_controller();

    // Signals for the parking_controller module
    reg clk;
    reg rst;
    reg car_entered;
    reg is_uni_car_entered;
    reg car_exited;
    reg is_uni_car_exited;
    
    wire [8:0] uni_parked_car;
    wire [8:0] f_parked_car;
    wire [8:0] uni_vacated_space;
    wire [8:0] f_vacated_space;
    wire is_uni_vacated_space;
    wire is_vacated_space;

    integer i;
    // Instantiate the parking_controller module
    parking_controller dut (
        .clk(clk),
        .rst(rst),
        .car_entered(car_entered),
        .is_uni_car_entered(is_uni_car_entered),
        .car_exited(car_exited),
        .is_uni_car_exited(is_uni_car_exited),
        .uni_parked_car(uni_parked_car),
        .f_parked_car(f_parked_car),
        .uni_vacated_space(uni_vacated_space),
        .f_vacated_space(f_vacated_space),
        .is_uni_vacated_space(is_uni_vacated_space),
        .is_vacated_space(is_vacated_space)
    );

    
    always #5 clk = ~clk;


    // Test cases and stimulus generation
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        car_entered = 0;
        is_uni_car_entered = 0;
        car_exited = 0;
        is_uni_car_exited = 0;

        // Reset the module
        #10 rst = 0;

        for (i = 0; i < 24; i = i + 1) begin
            $display("At time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);
            #1000;
        end


        // enter 202 free cars
        for (i = 0; i < 202; i = i + 1) begin
            car_entered = 1;
            is_uni_car_entered = 0;
            #2;
            car_entered = 0;
            is_uni_car_entered = 0;
            #2;
        end
        $display("enter 202 free cars: \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);

        // enter 200 university cars
        for (i = 0; i < 200; i = i + 1) begin
            car_entered = 1;
            is_uni_car_entered = 1;
            #5;
            car_entered = 0;
            is_uni_car_entered = 0;
            #5;
        end
        $display("enter 200 university cars: \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);

        // exit 100 university cars
        for (i = 0; i < 100; i = i + 1) begin
            car_exited = 1;
            is_uni_car_exited= 1;
            #5;
            car_exited = 0;
            is_uni_car_exited = 0;
            #5;
        end
        $display("exit 100 university cars: \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);

        // enter and exit 50 university cars
        for (i = 0; i < 50; i = i + 1) begin
            
            car_exited = 1;
            is_uni_car_exited= 1;

            #1 car_exited = 0;
            is_uni_car_exited = 0;
            
            #1 car_entered = 1;
            is_uni_car_entered = 1;
            
            #1 car_entered = 0;
            is_uni_car_entered = 0;
            #1;
        end
        $display("enter and exit 50 university cars: \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);



        // enter 400 university cars
        for (i = 0; i < 400; i = i + 1) begin
            car_entered = 1;
            is_uni_car_entered = 1;
            #1;
            car_entered = 0;
            is_uni_car_entered = 0;
            #1;
        end
        $display("enter 400 university cars: \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);

        // exit 25 university cars
        for (i = 0; i < 25; i = i + 1) begin
            car_exited = 1;
            is_uni_car_exited = 1;
            #1;
            car_exited = 0;
            is_uni_car_exited= 0;
            #1;
        end
        $display("exit 25 university cars: \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);


        #1000
        // enter 50 free cars
        for (i = 0; i < 50; i = i + 1) begin
            car_entered = 1;
            is_uni_car_entered = 0;
            #5;
            car_entered = 0;
            is_uni_car_entered = 0;
            #5;
        end
        $display("enter 50 free cars: \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);

        // exit 130 university cars
        for (i = 0; i < 130; i = i + 1) begin
            car_exited = 1;
            is_uni_car_exited = 1;
            #1;
            car_exited = 0;
            is_uni_car_exited= 0;
            #1;
        end
        $display("exit 130 university cars: \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);


        // enter and exit 50 free cars
        for (i = 0; i < 50; i = i + 1) begin
            
            car_exited = 1;
            is_uni_car_exited= 0;

            #1 car_exited = 0;
            is_uni_car_exited = 0;
            
            #1 car_entered = 1;
            is_uni_car_entered = 0;
            
            #1 car_entered = 0;
            is_uni_car_entered = 0;
            #1;
        end
        $display("enter and exit 50 free cars: \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);
        $display("clock counter:%d",dut.clock_counter);
        // enter 200 university cars
        for (i = 0; i < 200; i = i + 1) begin
            car_entered = 1;
            is_uni_car_entered = 1;
            #10;
            car_entered = 0;
            is_uni_car_entered = 0;
            #10;
        end
        $display("enter 200 university cars: \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);
        
        // enter 200 free cars
        for (i = 0; i < 200; i = i + 1) begin
            car_entered = 1;
            is_uni_car_entered = 0;
            #10;
            car_entered = 0;
            is_uni_car_entered = 0;
            #10;
        end
        $display("enter 200 free cars: \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);

        // exit 40 free cars
        for (i = 0; i < 40; i = i + 1) begin
            car_exited = 1;
            is_uni_car_exited = 0;
            #10;
            car_exited = 0;
            is_uni_car_exited= 0;
            #10;
        end
        $display("exit 40 free cars: \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);
                    
        // exit 300 university cars
        for (i = 0; i < 300; i = i + 1) begin
            car_exited = 1;
            is_uni_car_exited = 1;
            #10;
            car_exited = 0;
            is_uni_car_exited= 0;
            #10;
        end
        $display("exit 300 university cars : \nAt time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);
        #4000
        $display("At time %d, uni_parked_car = %d, f_parked_car = %d, uni_vacated_space = %d, f_vacated_space = %d",
                    dut.hour, uni_parked_car, f_parked_car, uni_vacated_space, f_vacated_space);

        #1000 $stop;
    end

endmodule

