function [zeta] = eqSysSolver(eta,omega)

zeta2 = 1/(1+(omega/eta)^2);
zeta=sqrt(zeta2);
end

