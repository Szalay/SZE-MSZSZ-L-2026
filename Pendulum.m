classdef Pendulum < handle
	
	properties
		% Modellparaméterek
		m = 1;
		L = 1;
		B = 0.2;

		% Kezdeti értékek
		omega_0 = 0;
		phi_0 = 0;

		% A megoldáshoz tartozó mennyiségek
		t;
		x;	% [omega; phi]
	end

	properties (Constant)
		g = 9.81;
	end

	properties (Dependent)
		J;
		x_0;
	end

	methods 
		
		function this = Pendulum(t_0, t_1)
			if nargin == 2
				this.t = [t_0, t_1];
			else
				this.t = t_0;
			end
		end

		function J = get.J(this)
			J = this.m*this.L^2;
		end

		function x_0 = get.x_0(this)
			x_0 = [this.omega_0; this.phi_0];
		end

		function dxdt = Model(this, ~, x)
			% x = [omega; phi]
			omega = x(1);
			phi = x(2);

			domegadt = 1/this.J * ( ...
				-this.m*Pendulum.g*this.L * sin(phi) - this.B*omega ...
				);
			dphidt = omega;

			dxdt = [domegadt; dphidt];
		end

		function Simulate(this)
			[this.t, this.x] = ode45(@this.Model, this.t, this.x_0);
		end

		function Plot(this)
			window = figure();
			window.Color = [1, 1, 1];
			
			% Szögsebesség
			subplot(2, 1, 1); hold on; grid on; box on;
			title("Szögsebesség", FontSize=18);
			xlabel("Idő, {\itt}, (s)", FontSize=14);
			ylabel("Szögsebesség, \omega, (rad/s)", FontSize=14);

			plot(this.t, this.x(:, 1), "r-", LineWidth=3);
			
			% Szöghelyzet
			subplot(2, 1, 2); hold on; grid on; box on;
			title("Szöghelyzet", FontSize=18);
			xlabel("Idő, {\itt}, (s)", FontSize=14);
			ylabel("Szöghelyzet, \phi, (°)", FontSize=14);

			plot(this.t, rad2deg(this.x(:, 2)), "b-", LineWidth=3);
		end

	end

	methods (Static)
		
		function Run()
			%p = Pendulum(0, 25);
			p = Pendulum(0:0.01:20);

			p.omega_0 = 1;

			p.Simulate();
			p.Plot();
		end

	end

end