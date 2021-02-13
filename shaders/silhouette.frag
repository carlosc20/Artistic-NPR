#version 330

// in
in vec3 GPosition; // Position in camera coords
in vec3 GNormal; // Normal in camera coords.
flat in int GIsEdge; // Whether or not we're drawing an edge

// uniforms
uniform vec4 LineColor;

// out
out vec4 colorOut;

void main(){
    if(GIsEdge == 1){
        colorOut = LineColor;
    }
    else{
        colorOut = vec4(1.0, 0.0, 0.0, 1.0);
    }
}