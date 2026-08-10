vec4 open_window(vec4 color, vec2 uv, float progress) {
    // Factor de saturación: 1.0 es normal, 1.5 es 50% más vivo, 2.0 es el doble
    float saturation = 1.5; 
    
    // Pesos estándar para luminancia (conversión a escala de grises)
    float luma = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
    
    // Mezclamos el color gris con el color original usando el factor
    vec3 col_saturada = mix(vec3(luma), color.rgb, saturation);
    
    return vec4(col_saturada, color.a);
}
