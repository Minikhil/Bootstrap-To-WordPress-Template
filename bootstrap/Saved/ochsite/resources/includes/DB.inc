<%
	class DBFactory
		private connections
		
		private sub CLASS_INITIALIZE
			Set connections = Server.CreateObject("scripting.dictionary")
		end sub
		
		public function connect (path)
			if (not connections.exists(path)) then
				Dim conn: Set conn = server.CreateObject ("adodb.connection")
				conn.Provider = "Microsoft.Jet.OLEDB.4.0"
				conn.Open path
				
				Dim db: Set db = new DBConnection
				db.init(conn)
				
				connections.add path, db
			end if
			
			Set connect = connections(path)
		end function
	end class
	
	class DBConnection
		private db
		
		private sub CLASS_INITIALIZE
			Dim db: Set db = Server.CreateObject ("adodb.connection")
			db.Provider = "Microsoft.Jet.OLEDB.4.0"
		end sub
		
		public function init (conn)
			Set db = conn
		end function
		
		public function query (query_string, args)
			Dim cmd: Set cmd = Server.CreateObject("adodb.command")
			cmd.CommandText = query_string
			Set cmd.ActiveConnection = db
			Set query = cmd.execute( , args)
		end function
		
		public function execute (prepared_query)
			Set execute = query(prepared_query.query_string, prepared_query.arguments)
		end function
		
		public function close
			db.close
			Set db = Nothing
		end function
	end class
	
	class PreparedQuery
		private query_string_
		private arguments_
		
		public function init (query_string, arguments)
			query_string_ = query_string
			arguments_ = arguments
		end function
		
		public property get query_string
			query_string = query_string_
		end property
		
		public property let query_string (val)
			query_string_ = val
		end property
		
		public property get arguments
			arguments = arguments_
		end property
		
		public property let arguments (val)
			arguments_ = val
		end property
	end class
	
	Dim connector: Set connector = new DBFactory
%>
