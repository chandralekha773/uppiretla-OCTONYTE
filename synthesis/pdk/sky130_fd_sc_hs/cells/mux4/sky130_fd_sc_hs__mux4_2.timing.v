/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/


`ifndef SKY130_FD_SC_HS__MUX4_2_TIMING_V
`define SKY130_FD_SC_HS__MUX4_2_TIMING_V

/**
 * mux4: 4-input multiplexer.
 *
 * Verilog simulation timing model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import sub cells.
`include "../../models/udp_pwrgood_pp_pg/sky130_fd_sc_hs__udp_pwrgood_pp_pg.v"
`include "../u_mux_4/sky130_fd_sc_hs__u_mux_4.v"

`celldefine
module sky130_fd_sc_hs__mux4_2 (
    X   ,
    A0  ,
    A1  ,
    A2  ,
    A3  ,
    S0  ,
    S1  ,
    VPWR,
    VGND
);

    // Module ports
    output X   ;
    input  A0  ;
    input  A1  ;
    input  A2  ;
    input  A3  ;
    input  S0  ;
    input  S1  ;
    input  VPWR;
    input  VGND;

    // Local signals
    wire    u_mux_40_out_X    ;
    wire    udp_pwrgood_pp$PG0_out_X;

    //                           Name          Output              Other arguments
    sky130_fd_sc_hs__u_mux_4_2   u_mux_40     (u_mux_40_out_X    , A0, A1, A2, A3, S0, S1    );
    sky130_fd_sc_hs__udp_pwrgood_pp$PG udp_pwrgood_pp$PG0 (udp_pwrgood_pp$PG0_out_X, u_mux_40_out_X, VPWR, VGND);
    buf                          buf0         (X                 , udp_pwrgood_pp$PG0_out_X        );

specify
if ((!A1&!A2&!A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((!A1&!A2&A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((!A1&A2&!A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((!A1&A2&A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((A1&!A2&!A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((A1&!A2&A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((A1&A2&!A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((A1&A2&A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A2&!A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A2&A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((!A0&A2&!A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((!A0&A2&A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((A0&!A2&!A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((A0&!A2&A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((A0&A2&!A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((A0&A2&A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&!A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&!A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((A0&A1&!A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((A0&A1&A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&!A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&!A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((A0&A1&!A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((A0&A1&A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&!A2&A3&S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&A2&!A3&S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((!A0&A1&!A2&!A3&!S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&!A2&A3&!S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&!A2&A3&S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&!A3&!S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&!A3&S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&A3&!S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&!A3&!S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&A3&!S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&A3&S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&A2&!A3&!S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((A0&!A1&A2&!A3&S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((A0&!A1&A2&A3&!S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((A0&A1&!A2&A3&S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((A0&A1&A2&!A3&S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&!A2&A3&S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&A2&!A3&!S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&A2&A3&!S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&A2&A3&S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&!A2&!A3&S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&!A3&!S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&!A3&S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&A3&!S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&!A3&!S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&A3&!S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&A3&S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&A2&A3&S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((A0&A1&!A2&!A3&!S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((A0&A1&!A2&!A3&S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((A0&A1&!A2&A3&!S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((A0&A1&A2&!A3&S0)) (S1 -=> X) = (0:0:0,0:0:0);
endspecify
endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HS__MUX4_2_TIMING_V
