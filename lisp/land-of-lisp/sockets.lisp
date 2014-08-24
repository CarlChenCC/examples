; SBCL socket stream wrapper

(defun socket-listen (port)
  (let ((socket (make-instance 'sb-bsd-sockets:inet-socket
			       :type :stream :protocol :tcp)))
    (setf (sb-bsd-sockets:sockopt-reuse-address socket) t)
    (sb-bsd-sockets:socket-bind socket '(127 0 0 1) port)
    (sb-bsd-sockets:socket-listen socket 1)
    (setf (sb-bsd-sockets:sockopt-reuse-address socket) 1)
    socket))

(defun socket-accept (s)
  (sb-bsd-sockets:socket-make-stream (sb-bsd-sockets:socket-accept s)
				     :output t
				     :input t))

(defun socket-server-close (s)
  (sb-bsd-sockets:socket-close s))
