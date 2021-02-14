#version 330


// in
in vec4 position;
in vec3 normal;

// uniforms
uniform mat4 mVM;
uniform mat3 mNormal;
uniform mat4 mView;
uniform mat4 mPVM;
uniform vec4 lightDir; // global space

// out
out vec3 vNormal;
out vec3 vPosition;
out vec3 vLightDir;

void main(){
    vNormal = normalize(mNormal * normal);
    vPosition = vec3(mVM * position);
    vLightDir = normalize(vec3(mView * -lightDir));

    gl_Position = mPVM * position;
}
