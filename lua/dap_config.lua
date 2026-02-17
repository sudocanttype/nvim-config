local dap = require('dap')
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file (global python)";
    program = "${file}";
    pythonPath = function()
      return '/usr/bin/python'
    end;
  },
  {
    type = 'python';
    request = 'launch';
    name = "Launch main2";
    program = "main2.py";
  },
  {
    type = 'python';
    request = 'launch';
    name = "Launch file (virtualenv python)";
    program = "${file}";
    pythonPath = function()
      return '${workspaceFolder}/venv/bin/python3'
    end;
  },
}


