classdef RLC < handle
	
	properties
		R;
		L;
		C;

		u_BE;
		t;
		y_0;

		y;	% [i; u_C]
	end

	methods
		% Tagfüggvények

		% Konstruktor (építő)
		function this = RLC(R, L, C, u_BE, t, y_0)
			this.R = R;
			this.L = L;
			this.C = C;

			this.u_BE = u_BE;
            this.t = t;
            this.y_0 = y_0;
		end

		% Modell
		function dydt = Model(this, t, y)
			% y = [i; u_C]
			i = y(1);
			u_C = y(2);
			
			didt = 1/this.L*(-this.R*i - u_C + this.u_BE(t));
			du_Cdt = 1/this.C *i;

			% dy/dt = [di/dt; du_C/dt]
			dydt = [didt; du_Cdt];
		end

		% Szimuláció
		function Simulate(this)
			[this.t, this.y] = ode45(@this.Model, this.t, this.y_0);
		end

		% Megjelenítés
		function Plot(this)
			w = figure();
			w.Color = [1, 1, 1];
			
			% Bemenet
			su = subplot(3, 1, 1);
			hold on; grid on; box on;

			title("Bemenet", FontSize=16);
			xlabel("Idő, t, s", FontSize=14);
			ylabel("Bemeneti feszültség, u", FontSize=14);
			
			plot(this.t, this.u_BE(this.t), "b-", LineWidth=3);

			% Áramerősség
			si = subplot(3, 1, 2);
			hold on; grid on; box on;

			title("Soros RLC kapcsolás szimulációja", FontSize=16);
			xlabel("Idő, t, s", FontSize=14);
			ylabel("Áramerősség, i, A", FontSize=14);

			plot(this.t, this.y(:, 1), "r-", LineWidth=3);
			
			% u_C
			sc = subplot(3, 1, 3);
			hold on; grid on; box on;

			title("Soros RLC kapcsolás szimulációja", FontSize=16);
			xlabel("Idő, t, s", FontSize=14);
			ylabel("A kapacitáson eső feszütlség, u_C, V", FontSize=14);

			plot(this.t, this.y(:, 2), "g-", LineWidth=3);

			linkaxes([su, si, sc], "x");
		end

	end

	methods (Static)
		
		function StepResponse()
			u = @(t) 2*ones(size(t));

			rlc = RLC(5, 100e-6, 10e-6, u, 0:1e-6:25e-3, [0; 0]);
			rlc.Simulate();
			rlc.Plot();
		end

	end

end