#version 330

// in
in vec3 vNormal;

// out
out vec3 colorOut;

void main(){
    // normalize to [0,1]
    // This colorOut stores normals in a G-Buffer so it could be used in the next shading pass
    // but this wasn't implemented
    colorOut = 0.5 * (vNormal + vec3(1.0));
}
