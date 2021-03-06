package com.yuzhouwan.hacker.effective;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

/**
 * Copyright @ 2017 yuzhouwan.com
 * All right reserved.
 * Function：String Stuff Test
 *
 * @author Benedict Jin
 * @since 2017/6/30
 */
public class StringStuffTest {

    @Test
    public void equalsNullPointException() throws Exception {
        String normal = "yuzhouwan.com", unmoral = null;
        try {
            if (normal.equals("yuzhouwan.com") && unmoral.equals("")) {     // bad habit
            }
        } catch (Exception e) {
            System.out.println("Will throw NullPointException!");
            assertEquals(true, e instanceof NullPointerException);
        }

        boolean equals = false;
        if ("yuzhouwan.com".equals(normal) || "".equals(unmoral)) {         // good habit
            equals = true;
        }
        assertEquals(true, equals);
    }
}
