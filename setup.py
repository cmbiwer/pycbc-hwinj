from setuptools import setup

project_name = "pycbc-hwinj"
project_version = "0.1.dev0"
project_url = "https://github.com/cmbiwer/pycbc-hwinjlog"
project_description = "A python package for generating a workflow tht cross-checks LIGO's various hardware injection logs."
project_keywords = ["ligo", "physics"]

author_name = "Christopher M. Biwer"
author_email = "cmbiwer@gmail.com"

scripts_list = ["bin/pycbc_check_frame_excitation",
                "bin/pycbc_check_frame_bitmask",
                "bin/pycbc_convert_segment_csv",
                "bin/pycbc_make_hwinj_workflow",
                "bin/pycbc_make_hwinj_table",
]

packages_list = ["hwinj",
]

data_dict = {
}

setup(name=project_name,
      version=project_version,
      description=project_description,
      url=project_url,
      keywords=project_keywords,
      author=author_name,
      author_email=author_email,
      scripts=scripts_list,
      packages=packages_list,
      package_data=data_dict,
)
