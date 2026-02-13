classdef FirstOrderSystem < handle
	
	properties
		% Tulajdonságok
		
		% Időállandó
		tau;

		% Állandósult állapoti erősítés
		K;

		% Kezdeti érték
		y_0;

		% Bemenet
		u;

		% Idővektor
		t;

		% Kimenet
		y;
	end

	methods
		% Tagfüggvények

		% Konstruktor (építő)
		function this = FirstOrderSystem(tau, K, y_0, u, t)
			this.tau = tau;
			this.K = K;
			this.y_0 = y_0;

			this.u = u;
			this.t = t;
		end

		% Modell
		function dydt = Model(this, t, y)
			% dy/dt = 1/tau (-y + K u(t))
			dydt = 1/this.tau * (-y + this.K * this.u(t));
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
			subplot(2, 1, 1);
			hold on; grid on; box on;

			title("Bemenet", FontSize=16);
			xlabel("Idő, t, s", FontSize=14);
			ylabel("Bemenet, u", FontSize=14);
			
			plot(this.t, this.u(this.t), "b-", LineWidth=3);

			% Kimenet
			subplot(2, 1, 2);
			hold on; grid on; box on;

			title("Elsőrendű rendszer szimulációja", FontSize=16);
			xlabel("Idő, t, s", FontSize=14);
			ylabel("Kimenet, y", FontSize=14);

			plot(this.t, this.y, "k-", LineWidth=3);
		end

	end

	methods (Static)
		
		function StepResponse()
			u = @(t) 2*ones(size(t));

			err = FirstOrderSystem(0.1, 2, -2, u, [0, 5]);
			err.Simulate();
			err.Plot();
		end
		
		function SineResponse()
			% Szinuszos bemenet
			u = @(t) 2*cos(2*pi*1*t);

			err = FirstOrderSystem(1, 1, 0, u, [0, 5]);
			err.Simulate();
			err.Plot();
		end

	end

end