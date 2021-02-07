#part-handler
import os
import tarfile

def list_types():
  return(['text/custom'])

def handle_part(data, ctype, filename, payload):
  print("[cloudinit-handler] %s %s" % (ctype, filename))
  if ctype == '__begin__' or ctype == '__end__':
    return

  if not os.path.exists(os.path.dirname(filename)):
    try:
      os.makedirs(os.path.dirname(filename))
    except OSError as exc: # Guard against race condition
      print("[cloudinit-handler] Error: %s" % (exc))
      if exc.errno != errno.EEXIST:
        raise

  with open(filename, 'w') as f:
    f.write(payload)
