package com.yuzhouwan.common.util;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

/**
 * Copyright @ 2016 suning.com
 * All right reserved.
 * Function：Exception Utils Test
 *
 * @author Benedict Jin
 * @since 2016/11/24
 */
public class ExceptionUtilsTest {

    @Test
    public void errorInfo() throws Exception {
        assertEquals("RuntimeException: Connection is closed!",
                ExceptionUtils.errorInfo(new RuntimeException("Connection is closed!")));
    }
}