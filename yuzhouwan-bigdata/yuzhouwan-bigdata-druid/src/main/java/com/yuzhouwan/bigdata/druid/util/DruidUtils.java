package com.yuzhouwan.bigdata.druid.util;

import com.yuzhouwan.common.util.PropUtils;
import com.yuzhouwan.common.util.StrUtils;

import java.lang.reflect.Field;

/**
 * Copyright @ 2016 yuzhouwan.com
 * All right reserved.
 * Function：Druid Utils
 *
 * @author Benedict Jin
 * @since 2016/12/2
 */
public class DruidUtils {

    public static String genTranquilityMetricsSpec(Class clazz) {

        PropUtils p = PropUtils.getInstance();
        String metricsSpecPrefix = p.getProperty("metrics.spec.prefix");
        String metricsSpecMiddle = p.getProperty("metrics.spec.middle");
        if (StrUtils.isEmpty(metricsSpecPrefix) || StrUtils.isEmpty(metricsSpecMiddle)) {
            throw new RuntimeException("Properties is empty!");
        }
        StringBuilder strBuilder = new StringBuilder(metricsSpecPrefix);
        Field[] fields = clazz.getDeclaredFields();
        String fieldName, simpleTypeName;
        for (Field field : fields) {
            fieldName = field.getName();
            simpleTypeName = field.getType().getSimpleName();
            if ("string".equalsIgnoreCase(simpleTypeName) ||
                    !"long".equalsIgnoreCase(simpleTypeName) && !"double".equalsIgnoreCase(simpleTypeName))
                continue;
            strBuilder.append(String.format(metricsSpecMiddle,
                    fieldName, fieldName, simpleTypeName, fieldName, fieldName, simpleTypeName));
        }
        strBuilder.append("]}");
        return strBuilder.toString().replaceAll(",]", "]");
    }
}
