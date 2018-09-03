// Módulo responsável por fornecer os registradores do MIPS;

module registers (regA, regB, regWrite, writeRegister, writeData, clk, outA, outB, reset);

    input clk, regWrite, reset;
	input [4:0] regA, regB, writeRegister;
	input [31:0] writeData;
	output reg [31:0] outA, outB;

    // Cria o array de registradores;
	reg [31:0] registers[0:31];

    // Seta os valores iniciais dos registradores;
	always @(reset) begin
		registers[0] = 32'b0; /*  ZR */ registers[1] = 32'b0; /* AT */
		registers[2] = 32'b0; /*  V0 */ registers[3] = 32'b0; /* V1 */
		registers[4] = 32'b0; /*  A0 */ registers[5] = 32'b0; /* A1 */
		registers[6] = 32'b0; /*  A2 */ registers[7] = 32'b0; /* A3 */
		registers[8] = 32'b00000000000000000000000000000001; /*  T0 */ registers[9] = 32'b00000000000000000000000000000010; /* T1 */
		registers[10] = 32'b00000000000000000000000000000011; /* T2 */ registers[11] = 32'b00000000000000000000000000000100; /* T3 */
		registers[12] = 32'b00000000000000000000000000000101; /* T4 */ registers[13] = 32'b00000000000000000000000000000111; /* T5 */
		registers[14] = 32'b00000000000000000000000000001000; /* T6 */ registers[15] = 32'b00000000000000000000000000001001; /* T7 */
		registers[16] = 32'b00000000000000000000000000000001; /* S0 */ registers[17] = 32'b00000000000000000000000000000010; /* S1 */
		registers[18] = 32'b00000000000000000000000000000011; /* S2 */ registers[19] = 32'b00000000000000000000000000000100; /* S3 */
		registers[20] = 32'b00000000000000000000000000000101; /* S4 */ registers[21] = 32'b00000000000000000000000000000110; /* S5 */
		registers[22] = 32'b00000000000000000000000000000111; /* S6 */ registers[23] = 32'b00000000000000000000000000001000; /* S7 */
		registers[24] = 32'b0; /* T8 */ registers[25] = 32'b0; /* T9 */
		registers[26] = 32'b0; /* K0 */ registers[27] = 32'b0; /* K1 */
		registers[28] = 32'b0; /* GP */ registers[29] = 32'b0; /* SP */
		registers[30] = 32'b0; /* FP */ registers[31] = 32'b0; /* RA */
	end

    // Sempre que regA e regB estiverem disponíveis, a saída recebe o registrador correspondente;
	always @(regA, regB) begin
		outA = registers[regA];
		outB = registers[regB];
	end

    // Sobrescreve o valor do registrador sempre que a borda de clock for de descida e regWrite for 1;
	always @(negedge clk) begin
		if(regWrite == 1'b1) begin
			registers[writeRegister] = writeData;
		end
	end
endmodule
