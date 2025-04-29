package org.example.primeFactors;

import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.empty;
import static org.hamcrest.Matchers.is;

public class PrimeFactorsTest {
    @Test
    public void factors() {
        assertThat(factorsOf(1), is(empty()));
    }

    private List<Integer> factorsOf(int n) {
        return null;
    }

}
