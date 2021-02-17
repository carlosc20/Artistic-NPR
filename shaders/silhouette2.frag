#version 330

// in
in vec3 gSpine;

// uniforms
uniform vec4 lineColor;
uniform sampler2D depthSampler;

// out
out vec4 colorOut;

void main(){
    vec2 texCoord = (gSpine.xy + 1.0) / 2.0;
    float depth = texture2D(depthSampler, texCoord).r;

    if (depth < gl_FragCoord.z)
        discard;

    colorOut = lineColor;
}