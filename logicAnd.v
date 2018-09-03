// Módulo responsável por fazer a lógica AND entre dois valores especificados;

module logicAnd (andIn1, andIn2, andOut);

    input andIn1, andIn2;
    output wire andOut;

    // Operação AND entre as duas entradas;
    assign andOut = andIn1 && andIn2;

endmodule
