import sys
PS = '\\' # Linux Machine
PS = '/' # Windows Machine
generatorPath = 'C:'+PS+'Users'+PS+'Charlie'+PS+'Documents'+PS+'GitHub'+PS+'goofPy'+PS+'source'
sys.path.append(generatorPath)
import generator as g
import fortran_property as FP

def add_modules(g,T,F,priv,real):

	m_name = 'stats_period'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('t_start',real,priv)
	g.module[m_name].add_prop('t_start_actual',real,priv)
	g.module[m_name].add_prop('t_stop',real,priv)
	g.module[m_name].add_prop('period',real,priv)
	g.module[m_name].add_prop('N_stats_collected','integer',priv)
	g.module[m_name].add_prop('compute_stats','logical',priv)
	g.module[m_name].add_prop('define_t_start_actual','logical',priv)
	g.module[m_name].add_prop('t_start_actual_defined','logical',priv)
	g.module[m_name].add_prop('export_stats','logical',priv)
	g.module[m_name].add_prop('exported_stats','logical',priv)

	m_name = 'time_statistics_params'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('collect','logical',priv)
	g.module[m_name].add_prop('O1_stats','stats_period',priv)
	g.module[m_name].add_prop('O2_stats','stats_period',priv)

	m_name = 'mirror_props'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('mirror','logical',priv)
	g.module[m_name].add_prop('mirror_face','integer',priv)
	g.module[m_name].add_prop('mirror_sign',real,priv,F,1,3)
	g.module[m_name].add_prop('mirror_sign_a',real,priv,F,1,3)

	m_name = 'export_logicals'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('export_analytic','logical',priv)
	g.module[m_name].add_prop('export_meshes','logical',priv)
	g.module[m_name].add_prop('export_vort_SF','logical',priv)
	g.module[m_name].add_prop('export_mat_props','logical',priv)
	g.module[m_name].add_prop('export_cell_volume','logical',priv)
	g.module[m_name].add_prop('export_ICs','logical',priv)
	g.module[m_name].add_prop('export_planar','logical',priv)
	g.module[m_name].add_prop('export_symmetric','logical',priv)
	g.module[m_name].add_prop('export_mesh_block','logical',priv)
	g.module[m_name].add_prop('export_soln_only','logical',priv)
	g.module[m_name].add_prop('defined','logical',priv)

	m_name = 'geometry_props'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('geometry','integer',priv)
	g.module[m_name].add_prop('tw',real,priv)
	g.module[m_name].add_prop('periodic_dir','integer',priv,F,1,3)
	g.module[m_name].add_prop('apply_BC_order','integer',priv,F,1,6)

	m_name = 'equation_term'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('add','logical',priv)
	g.module[m_name].add_prop('scale',real,priv)

	m_name = 'energy_terms'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('advection','equation_term',priv)
	g.module[m_name].add_prop('diffusion','equation_term',priv)
	g.module[m_name].add_prop('KE_diffusion','equation_term',priv)
	g.module[m_name].add_prop('viscous_dissipation','equation_term',priv)
	g.module[m_name].add_prop('joule_heating','equation_term',priv)
	g.module[m_name].add_prop('volumetric_heating','equation_term',priv)

	m_name = 'momentum_terms'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('pressure_grad','equation_term',priv)
	g.module[m_name].add_prop('advection_divergence','equation_term',priv)
	g.module[m_name].add_prop('advection_convection','equation_term',priv)
	g.module[m_name].add_prop('advection_base_flow','equation_term',priv)
	g.module[m_name].add_prop('diffusion','equation_term',priv)
	g.module[m_name].add_prop('mean_pressure_grad','equation_term',priv)
	g.module[m_name].add_prop('JCrossB','equation_term',priv)
	g.module[m_name].add_prop('Q2D_JCrossB','equation_term',priv)
	g.module[m_name].add_prop('Buoyancy','equation_term',priv)
	g.module[m_name].add_prop('Gravity','equation_term',priv)

	m_name = 'induction_terms'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('advection','equation_term',priv)
	g.module[m_name].add_prop('diffusion','equation_term',priv)
	g.module[m_name].add_prop('unsteady_B0','equation_term',priv)
	g.module[m_name].add_prop('current','equation_term',priv)
	g.module[m_name].add_prop('B_applied','equation_term',priv)

	# In MOONS, these parameters are defined for default values:
	# integer,parameter :: frequency_coeff_default = 1
	# integer,parameter :: frequency_base_default = 10
	# integer,parameter :: frequency_exp_default = 6
	m_name = 'export_frequency_params'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('export_ever','logical',priv)
	g.module[m_name].add_prop('export_first_step','logical',priv)
	g.module[m_name].add_prop('export_now','logical',priv)
	g.module[m_name].add_prop('frequency_coeff','integer',priv)
	g.module[m_name].add_prop('frequency_base','integer',priv)
	g.module[m_name].add_prop('frequency_exp','integer',priv)

	m_name = 'export_frequency'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('info','export_frequency_params',priv)
	g.module[m_name].add_prop('unsteady_0D','export_frequency_params',priv)
	g.module[m_name].add_prop('unsteady_1D','export_frequency_params',priv)
	g.module[m_name].add_prop('unsteady_2D','export_frequency_params',priv)
	g.module[m_name].add_prop('unsteady_3D','export_frequency_params',priv)
	g.module[m_name].add_prop('final_solution','export_frequency_params',priv)
	g.module[m_name].add_prop('restart_files','export_frequency_params',priv)
	g.module[m_name].add_prop('dir','string',priv)
	g.module[m_name].add_prop('name','string',priv)

	m_name = 'flow_control_logicals'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('post_process','logical',priv)
	g.module[m_name].add_prop('skip_solver_loop','logical',priv)
	g.module[m_name].add_prop('stop_before_solve','logical',priv)
	g.module[m_name].add_prop('stop_after_mesh_export','logical',priv)
	g.module[m_name].add_prop('Poisson_test','logical',priv)
	g.module[m_name].add_prop('Taylor_Green_Vortex_test','logical',priv)

	m_name = 'dimensionless_params'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('Re',real,priv)
	g.module[m_name].add_prop('Al',real,priv)
	g.module[m_name].add_prop('N',real,priv)
	g.module[m_name].add_prop('Ha',real,priv)
	g.module[m_name].add_prop('tau',real,priv)
	g.module[m_name].add_prop('Gr',real,priv)
	g.module[m_name].add_prop('Fr',real,priv)
	g.module[m_name].add_prop('Pr',real,priv)
	g.module[m_name].add_prop('Pe',real,priv)
	g.module[m_name].add_prop('Ec',real,priv)
	g.module[m_name].add_prop('Rem',real,priv)
	g.module[m_name].add_prop('c_w',real,priv,F,1,6)
	g.module[m_name].add_prop('Robin_coeff',real,priv,F,1,6)
	g.module[m_name].add_prop('Q',real,priv)
	g.module[m_name].add_prop('sig_local_over_sig_f',real,priv)
	g.module[m_name].add_prop('KE_scale',real,priv)
	g.module[m_name].add_prop('ME_scale',real,priv)
	g.module[m_name].add_prop('JE_scale',real,priv)
	g.module[m_name].add_prop('L_eta',real,priv)
	g.module[m_name].add_prop('U_eta',real,priv)
	g.module[m_name].add_prop('t_eta',real,priv)
	g.module[m_name].add_prop('dir','string',priv)
	g.module[m_name].add_prop('name','string',priv)

	m_name = 'sim_params'
	g.add_module(m_name)
	g.module[m_name].set_folder_name(__name__.split('.')[1])
	g.module[m_name].set_used_modules(['IO_tools_mod'])
	g.module[m_name].add_prop('VS','var_set',priv)
	g.module[m_name].add_prop('MP_mom','mesh_params',priv)
	g.module[m_name].add_prop('MP_ind','mesh_params',priv)
	g.module[m_name].add_prop('MP_sigma','mesh_params',priv)
	g.module[m_name].add_prop('DP','dimensionless_params',priv)
	g.module[m_name].add_prop('EL','export_logicals',priv)
	g.module[m_name].add_prop('EF','export_frequency',priv)
	g.module[m_name].add_prop('ET','energy_terms',priv)
	g.module[m_name].add_prop('MT','momentum_terms',priv)
	g.module[m_name].add_prop('IT','induction_terms',priv)
	g.module[m_name].add_prop('GP','geometry_props',priv)
	g.module[m_name].add_prop('MP','mirror_props',priv)
	g.module[m_name].add_prop('coupled','time_marching_params',priv)
	g.module[m_name].add_prop('FCL','flow_control_logicals',priv)
	g.module[m_name].add_prop('TSP','time_statistics_params',priv)
	g.module[m_name].add_prop('export_safe_period',real,priv)
	g.module[m_name].add_prop('restart_meshes','logical',priv)
	g.module[m_name].add_prop('export_heavy','logical',priv)
	g.module[m_name].add_prop('matrix_based','logical',priv)
	g.module[m_name].add_prop('print_every_MHD_step','logical',priv)
	g.module[m_name].add_prop('couple_time_steps','logical',priv)
	g.module[m_name].add_prop('finite_Rem','logical',priv)
	g.module[m_name].add_prop('include_vacuum','logical',priv)
	g.module[m_name].add_prop('embed_B_interior','logical',priv)
	g.module[m_name].add_prop('compute_surface_power','logical',priv)
	g.module[m_name].add_prop('uniform_B0_dir','integer',priv)
	g.module[m_name].add_prop('mpg_dir','integer',priv)
	g.module[m_name].add_prop('uniform_gravity_dir','integer',priv)

	return g