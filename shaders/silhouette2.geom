#version 330

layout(triangles_adjacency) in;
layout (triangle_strip, max_vertices=15) out;

// uniforms
uniform float edgeOverdraw; // percentage to extend the quads beyond the edge
uniform float edgeWidth;    // width of the silhouette edge in clip coords.
uniform int normalThreshold;    

// out
out vec3 gSpine;

// Check if a point is visible by the camara
bool isVisible(vec3 a){
    return a.x > -2 && a.x < 2 && a.y > -2 && a.y < 2;
}

// takes three triangle corners (in screen space), returning true for front-facing triangles
// if z coordinate of normal vector is positive
bool isFrontFacing(vec3 a, vec3 b, vec3 c){
    float threshold  = 0.0;
    if(normalThreshold == 1){
        threshold = -0.000001;
    }

    return ((a.x * b.y - b.x * a.y) +
            (b.x * c.y - c.x * b.y) +
            (c.x * a.y - a.x * c.y)) > 0 && isVisible(a) && isVisible(b) && isVisible(c);
}

// emits quad between two points (edge)
void emitEdgeQuad(vec3 p1, vec3 p2){

    vec2 ext = edgeOverdraw * (p2.xy - p1.xy); // edge overdraw vector

    vec2 v = normalize(p2.xy - p1.xy);
    vec2 n = vec2(-v.y, v.x) * edgeWidth; //edge Width vector
    

    /*
        A -- p1 --- p2 -- B  
        |                 |
        |                 |
        C --------------- D
    */

    // A
    gSpine = p1;
    gl_Position = vec4( p1.xy + n - ext, p1.z, 1.0 );
    EmitVertex();

    // C
    gl_Position = vec4( p1.xy - n - ext, p1.z, 1.0 );
    EmitVertex();

    // B
    gSpine = p2;
    gl_Position = vec4( p2.xy + n + ext, p2.z, 1.0 );
    EmitVertex();

    // D
    gl_Position = vec4( p2.xy - n + ext, p2.z, 1.0 );
    EmitVertex();
    
    EndPrimitive();
}

void main(){
    /*
    5---4---3
     \ / \ /
      0---2
       \ /
        1
    */
    vec3 p0 = gl_in[0].gl_Position.xyz / gl_in[0].gl_Position.w;
    vec3 p1 = gl_in[1].gl_Position.xyz / gl_in[1].gl_Position.w;
    vec3 p2 = gl_in[2].gl_Position.xyz / gl_in[2].gl_Position.w;
    vec3 p3 = gl_in[3].gl_Position.xyz / gl_in[3].gl_Position.w;
    vec3 p4 = gl_in[4].gl_Position.xyz / gl_in[4].gl_Position.w;
    vec3 p5 = gl_in[5].gl_Position.xyz / gl_in[5].gl_Position.w;

    if(isFrontFacing(p0, p2, p4)){
        if(!isFrontFacing(p0, p1, p2)){
            emitEdgeQuad(p0, p2);
        }

        if(!isFrontFacing(p2, p3, p4)){
            emitEdgeQuad(p2, p4);
        }

        if(!isFrontFacing(p4, p5, p0)){
            emitEdgeQuad(p4, p0);
        }
    }
}