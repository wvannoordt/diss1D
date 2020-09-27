function [oper]  = buildOp(N, coeff, periodize)  
  oper = zeros(N,N);
  for i = 1:N
    hw = round(0.5*(length(coeff)-1));
    for k = 1:length(coeff)
      idx = i - hw - 1 + k;
      didWrap = false;
      if (idx > N)
        idx = idx-N;
        didWrap = true;
      end
      if (idx < 1)
        idx = idx+N;
        didWrap = true;
      end
      val = coeff(k);
      if (~didWrap || periodize)
        oper(i, idx) = val;
      end
    end
  end
end