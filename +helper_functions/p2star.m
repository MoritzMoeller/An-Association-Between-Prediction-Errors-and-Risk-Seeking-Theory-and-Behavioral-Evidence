function sig = p2star(p)
sig = '';
if p > 0.05
    sig = [sig, 'n.s.'];
end
if p < 0.05
    sig = [sig, '*'];
end
if p < 0.01
    sig = [sig, '*'];
end
if p < 0.001
    sig = [sig, '*'];
end
end