import os
if os.name == 'posix':
    pass # this is the operating system name
elif os.name == 'nt':
    clear = lambda: os.system('cls')
    clear()
import inspect; import copy
from collections import OrderedDict
import sys
PS = '\\' # Linux Machine
PS = '/' # Windows Machine
generatorPath = 'C:'+PS+'Users'+PS+'Charlie'+PS+'Documents'+PS+'GitHub'+PS+'goofPy'+PS+'source'
sys.path.append(generatorPath)
import generator as g
import fortran_property as FP

import modules.sim_params as sim_params
import modules.var_set as var_set
import modules.stop_clock as stop_clock
import modules.grid as grid
import modules.block as block
import modules.grid_field as grid_field
import modules.mesh_params as mesh_params
import modules.data_location as data_location
import modules.boundary_conditions as boundary_conditions
import modules.block_field as block_field
import modules.mesh as mesh
import modules.fields as fields
import modules.probe as probe
import modules.time_statistics as time_statistics
import modules.sub_domain as sub_domain
import modules.physical_domain as physical_domain
import modules.mesh_domain as mesh_domain
import modules.apply_face_BC_op as apply_face_BC_op
import modules.procedure_array as procedure_array
import modules.dir_tree as dir_tree
import modules.stitches as stitches
import modules.PCG as PCG
import modules.FFT_solver as FFT_solver
import modules.governing_equations as governing_equations
import modules.MOONS as MOONS

# add_prop parameters:
#     1) name (string)
#     2) data type (integer,real etc.) (string)
#     3) Object / allocatable / Primitive / Parameter (string)
#     4) dimension (int)

# init(var,type,privacy,allocatable,rank,dimension,procedure)
# init(var,type,privacy) # defaults to allocatable = False, rank = 1, dimension = 1, procedure = False

g = g.generator()
g.set_directories(os.path.abspath(__file__),PS)
g.add_base_files(['precision'+PS+'current_precision.f90'])
g.add_base_files(['IO'+PS+'inquire_funcs.f90'])
g.add_base_files(['IO'+PS+'IO_check.f90'])
g.add_base_files(['IO'+PS+'IO_tools.f90'])
g.add_base_files(['string'+PS+'string.f90'])
g.add_base_files(['string'+PS+'string_aux.f90'])
g.add_base_modules(['string'])

# g.print()
priv = 'public'
log = 'logical'
real = 'real(cp)' # ! Double precision (default)
T = True
F = False
g.set_default_real('0.0_cp')

# --------------- Small data structures
g = dir_tree.add_modules(g,T,F,priv,real)
g = stitches.add_modules(g,T,F,priv,real)

g = probe.add_modules(g,T,F,priv,real)
g = mesh_params.add_modules(g,T,F,priv,real)
g = grid.add_modules(g,T,F,priv,real)
g = var_set.add_modules(g,T,F,priv,real)
g = stop_clock.add_modules(g,T,F,priv,real)
g = sim_params.add_modules(g,T,F,priv,real)

# --------------- Medium data structures
g = grid_field.add_modules(g,T,F,priv,real) # small
g = data_location.add_modules(g,T,F,priv,real) # small
g = sub_domain.add_modules(g,T,F,priv,real)
g = physical_domain.add_modules(g,T,F,priv,real)
g = apply_face_BC_op.add_modules(g,T,F,priv,real) # Handwritten interfaces, modify
g = procedure_array.add_modules(g,T,F,priv,real)
g = boundary_conditions.add_modules(g,T,F,priv,real)

# --------------- Large data structures
g = block.add_modules(g,T,F,priv,real)
g = block_field.add_modules(g,T,F,priv,real)
g = mesh.add_modules(g,T,F,priv,real)
g = fields.add_modules(g,T,F,priv,real)
g = mesh_domain.add_modules(g,T,F,priv,real)
g = time_statistics.add_modules(g,T,F,priv,real)

# --------------- Very large data structures
g = PCG.add_modules(g,T,F,priv,real)
g = FFT_solver.add_modules(g,T,F,priv,real)
g = governing_equations.add_modules(g,T,F,priv,real)
g = MOONS.add_modules(g,T,F,priv,real)

g.generate_code()
