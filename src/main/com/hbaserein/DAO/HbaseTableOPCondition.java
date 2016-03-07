package com.aswinrkrishnan.hbaserein.DAO;

import com.aswinrkrishnan.hbaserein.DAO.HbaseTableOP;

public static enum HbaseTableOP.Condition {
    startsWith,
    equals,
    contains;


    private HbaseTableOP.Condition(String string2, int n2) {
    }
}
