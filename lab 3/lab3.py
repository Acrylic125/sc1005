

def decodeToSegments(x_):
    # x = [0,0,0,0]
    x = [
        True if (x_[0] == 1) else False,
        True if (x_[1] == 1) else False,
        True if (x_[2] == 1) else False, 
        True if (x_[3] == 1) else False
    ]
    # print(f"{x_} {x}")
    seg = [
        False, False, False, False, False, False, False
    ]
    # // x format {msb, ., ., lsb}
    # // seg[6:0] format {g, f, e, d, c, b, a} - active high
    # // segment a, b, e, g expressions are given 
    seg[0] = (not x[3] and x[2] and x[0]) or (x[2] and x[1]) or (not x[3] and x[1]) or (x[3] and not x[0]) or (x[3] and not x[2] and not x[1]) or (not x[2] and not x[0])
    seg[1] = (not x[3] and not x[2]) or (not x[2] and not x[0]) or (not x[3] and not x[1] and not x[0]) or (not x[3] and x[1] and x[0]) or (x[3] and not x[1] and x[0])
    seg[4] = (x[3] and x[2]) or (x[3] and x[1]) or (not x[2] and not x[0]) or (x[1] and not x[0])
    seg[6] = (x[1] and not x[0]) or (x[3] and not x[2]) or (x[3] and x[0]) or (not x[2] and x[1]) or (not x[3] and x[2] and not x[1])
    seg[2] = (not x[3] and not x[1]) or (not x[3] and x[0]) or (not x[1] and x[0]) or (not x[3] and x[2]) or (x[3] and not x[2])
    seg[3] = (x[3] and not x[1]) or (not x[3] and not x[2] and not x[0]) or (not x[2] and x[1] and x[0]) or (x[2] and not x[1] and x[0]) or (x[2] and x[1] and not x[0])
    seg[5] = (not x[1] and not x[0]) or (x[2] and not x[0]) or (x[3] and not x[2]) or (x[3] and x[1]) or (not x[3] and x[2] and not x[1])

    # segment a= x3'x2x0 + x2x1 + x3'x1 + x3x0' + x3x2'x1' + x2'x0'
    # seg[0] = ~x[3]&x[2]&x[0]|x[2]&x[1]|~x[3]&x[1]|x[3]&~x[0]|x[3]&~x[2]&~x[1]|~x[2]&~x[0];
    # segment b= x3'x2' + x2'x0' + x3'x1'x0' + x3'x1x0 + x3x1'x0
    # seg[1] = ~x[3]&~x[2]|~x[2]&~x[0]|~x[3]&~x[1]&~x[0]|~x[3]&x[1]&x[0]|x[3]&~x[1]&x[0];
    # segment e= x3x2 + x3x1 + x2'x0' + x1x0'
    # seg[4] = x[3]&x[2]|x[3]&x[1]|~x[2]&~x[0]|x[1]&~x[0];
    # segment g= x1x0' + x3x2' + x3x0 + x2'x1 + x3'x2x1'
    # seg[6] = x[1]&~x[0]|x[3]&~x[2]|x[3]&x[0]|~x[2]&x[1]|~x[3]&x[2]&~x[1];

    # c = x3'x1' + x3'x0 + x1'x0 + x3'x2 + x3x2'
    # seg[2] = (~x[3]&~x[1]) | (~x[3]&x[0]) | (~x[1]&x[0]) | (~x[3]&x[2]) | (x[3]&~x[2])

    # d = x3x1' + x3'x2'x0' + x2'x1x0 + x2x1'x0 + x2x1x0'
    # seg[3] = (x[3] & ~x[1]) | (~x[3] & ~x[2] & ~x[0]) | (~x[2] & x[1] & x[0]) | (x[2] & ~x[1] & x[0]) | (x[2] & x[1] & ~x[0])

    # f = x1'x0' + x2x0' + x3x2' + x3x1 + x3'x2x1'
    # seg[5] = (~x[1] & ~x[0]) | (x[2] & ~x[0]) | (x[3] & ~x[2]) | (x[3] & x[1]) | (~x[3] & x[2] & ~x[1])
    return seg

def display_segment(segments):
    def h(seg): return "_" if seg else " "
    def v(seg): return "|" if seg else " "

    def p(seg): return "1" if seg else "0"
    a,b,c,d,e,f,g = segments
    return [
        f"{p(a)}{p(b)}{p(c)}{p(d)}{p(e)}{p(f)}{p(g)}",
        f" {h(a)} ",
        f"{v(f)} {v(b)}",
        f" {h(g)} ",
        f"{v(e)} {v(c)}",
        f" {h(d)} ",
    ]

def p(seg): return "0" if seg else "1"

for i in range(16):
    x3, x2, x1, x0 = (i >> 3) & 1, (i >> 2) & 1, (i >> 1) & 1, i & 1
    # segments = decodeToSegments([x3, x2, x1, x0])
    segments = decodeToSegments([x0, x1, x2, x3])
    display = display_segment(segments)
    a,b,c,d,e,f,g = segments

    print(f"4'b{x3}{x2}{x1}{x0}: seg_L = 7'b{p(g)}{p(f)}{p(e)}_{p(d)}{p(c)}{p(b)}{p(a)}; // '{i}'")
    
    # print(f"--- {i} ({x3}{x2}{x1}{x0}) ---")
    # for line in display:
    #     print(line)
    # print()