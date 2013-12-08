using UnityEngine;
using System.Collections;

/* 
Class to control the camera within the game world.
Camera will move up, down, left and right when the users mouse hits the side of the screen in 2D space.
Camera will check desired location, will stop if over limits.
Camera can also be controlled by W,A,S,D keys, will call the same movement as the mouse events.
*/


public class WorldCamera : MonoBehaviour {
	
	#region structs
	
	//box limits Struct
	public struct BoxLimit {
		public float LeftLimit;
		public float RightLimit;
		public float TopLimit;
		public float BottomLimit;
		
	}
	
	#endregion
	
	
	#region class variables
	
	public static BoxLimit cameraLimits       = new BoxLimit();
	public static BoxLimit mouseScrollLimits  = new BoxLimit();
	public static WorldCamera Instance;

	private float cameraMoveSpeed = 60f;
	private float shiftBonus      = 45f;
	private float mouseBoundary   = 25f;

	//Camera rotation
	private float mouseX;
	private float mouseY;

	private bool VerticalRotationEnabled = true;
	private float VerticalRotationMin = 0;
	private float VerticalRotationMax = 65f;

	//Terrain boundaries
	public Terrain WorldTerrain;
	public float WorldTerrainPadding = 50f;

	//Camera Zoom
	public GameObject MainCamera;
	private GameObject ScrollAngle;
	private float maxCameraHeight = 850f;

	
	#endregion
	
	
	void Awake () {
		Instance = this;
	}

	void Start () {
		
		//Declare camera limits
		cameraLimits.LeftLimit   = WorldTerrain.transform.position.x + WorldTerrainPadding;
		cameraLimits.RightLimit  = WorldTerrain.terrainData.size.x - WorldTerrainPadding;
		cameraLimits.TopLimit    = WorldTerrain.terrainData.size.z - WorldTerrainPadding;
		cameraLimits.BottomLimit = WorldTerrain.transform.position.z + WorldTerrainPadding;
		
		//Declare Mouse Scroll Limits
		mouseScrollLimits.LeftLimit   = mouseBoundary;
		mouseScrollLimits.RightLimit  = mouseBoundary;
		mouseScrollLimits.TopLimit    = mouseBoundary;
		mouseScrollLimits.BottomLimit = mouseBoundary;

		ScrollAngle = new GameObject ();
			
	}

	void LateUpdate () {

		HandleMouseRotation ();

		ApplyScroll ();
						
		if(CheckIfUserCameraInput())
		{
			//print(keyboardMove);
			Vector3 desiredTranslation = GetDesiredTranslation();
			
			if(!isDesiredPositionOverBoundaries(desiredTranslation))
			{
				this.transform.Translate(desiredTranslation);
			}
		}

		mouseX = Input.mousePosition.x;
		mouseY = Input.mousePosition.y;
	}
	

	//Handles the mouse vertically and horizontally
	public void HandleMouseRotation () {
	
		float easeFactor = 5f;
		if (Input.GetMouseButton (1) /* && Input.GetKey (KeyCode.LeftControl)*/) 
		{
			//Horizontal Rotation
			if(Input.mousePosition.x != mouseX)
			{
				float cameraRotationY = (Input.mousePosition.x - mouseX) * easeFactor * Time.deltaTime;
				this.transform.Rotate(0, cameraRotationY, 0);
			}


			//Vertical Rotation
			if(VerticalRotationEnabled && Input.mousePosition.y != mouseY)
			{
				GameObject MainCamera = this.gameObject.transform.FindChild("Main Camera").gameObject;

				float cameraRotationX = (mouseY - Input.mousePosition.y) * easeFactor * Time.deltaTime;
				float desiredRotationX = MainCamera.transform.eulerAngles.x + cameraRotationX;

				if(desiredRotationX >= VerticalRotationMin && desiredRotationX <= VerticalRotationMax)
				{
					MainCamera.transform.Rotate(cameraRotationX, 0, 0);
				}
			}
		}

	}

	public void ApplyScroll () {
		float deadZone = 0.01f;
		float easeFactor = 20f;
		float ScrollWheelValue = Input.GetAxis ("Mouse ScrollWheel") * easeFactor;

		//check deadzone
		if (ScrollWheelValue > -deadZone && ScrollWheelValue < deadZone || ScrollWheelValue == 0f)
			return;

		float EulerAnglesX = MainCamera.transform.localEulerAngles.x;
		float EulerAnglesY = this.transform.eulerAngles.y;
		float EulerAnglesZ = this.transform.eulerAngles.z;

		//configure ScrollAngle gameobject
		ScrollAngle.transform.position = transform.position;
		ScrollAngle.transform.eulerAngles = new Vector3 (EulerAnglesX, EulerAnglesY, EulerAnglesZ);
		ScrollAngle.transform.Translate (Vector3.forward * ScrollWheelValue);

		Vector3 desiredScrollPosition = ScrollAngle.transform.position;

		//check boundaries
		if (desiredScrollPosition.x < cameraLimits.LeftLimit || desiredScrollPosition.x > cameraLimits.RightLimit)
			return;

//		if (desiredScrollPosition.z < cameraLimits.TopLimit || desiredScrollPosition.z > cameraLimits.BottomLimit)
//			return;
//		print ("passed z");

		if (desiredScrollPosition.y > maxCameraHeight)
			return;

		//update camera position
		this.transform.position = desiredScrollPosition;

		return;
	
	}
	
	
	//Check if the user is inputting commands for the camera to move
	public bool CheckIfUserCameraInput () {
		bool keyboardMove;
		bool mouseMove;
		bool canMove;
		
		//check keyboard		
		if(WorldCamera.AreCameraKeyboardButtonsPressed()){
			keyboardMove = true;			
		} else {
			keyboardMove = false;
		}
		
		//check mouse position
		if(WorldCamera.IsMousePositionWithinBoundaries())
			mouseMove = true; else mouseMove = false;
		
		
		if(keyboardMove || mouseMove)
			canMove = true; else canMove = false;
		
		return canMove;
	}
	
	
	
	
	//Works out the cameras desired location depending on the players input
	public Vector3 GetDesiredTranslation () {
		float moveSpeed = 0f;
		float desiredX = 0f;
		float desiredZ = 0f;
		
		if(Input.GetKey(KeyCode.LeftShift) || Input.GetKey(KeyCode.RightShift))
			moveSpeed = (cameraMoveSpeed + shiftBonus) * Time.deltaTime;
		else
			moveSpeed = cameraMoveSpeed * Time.deltaTime;
		
		
		//move via keyboard
		if(Input.GetKey(KeyCode.W))
			desiredZ = moveSpeed;
		
				
		if(Input.GetKey(KeyCode.S))
			desiredZ = moveSpeed * -1;
		
		
		if(Input.GetKey(KeyCode.A))
			desiredX = moveSpeed * -1;
		
		
		if(Input.GetKey(KeyCode.D))
			desiredX = moveSpeed;
		
		
		
		
		//move via mouse
		if(Input.mousePosition.x < mouseScrollLimits.LeftLimit){
			desiredX = moveSpeed * -1;
		}
		
		if(Input.mousePosition.x > (Screen.width - mouseScrollLimits.RightLimit)){
			desiredX = moveSpeed;
		}
		
		if(Input.mousePosition.y < mouseScrollLimits.BottomLimit){
			desiredZ = moveSpeed * -1;
		}
		
		if(Input.mousePosition.y > (Screen.height - mouseScrollLimits.TopLimit)){
			desiredZ = moveSpeed;
		}
			
		return new Vector3(desiredX, 0, desiredZ);
	}
	
	
	
	
	
	//checks if the desired position crosses boundaries
	public bool isDesiredPositionOverBoundaries (Vector3 desiredTranslation) {

		Vector3 desiredWorldPosition = this.transform.TransformPoint (desiredTranslation);

		bool overBoundaries = false;
		//check boundaries
		if(desiredWorldPosition.x < cameraLimits.LeftLimit)
			overBoundaries = true;
		
		if(desiredWorldPosition.x > cameraLimits.RightLimit)
			overBoundaries = true;
			
		if(desiredWorldPosition.z > cameraLimits.TopLimit)
			overBoundaries = true;
			
		if(desiredWorldPosition.z < cameraLimits.BottomLimit)
			overBoundaries = true;
		
		return overBoundaries;
	}
	
	
	
	
	
	#region Helper functions
		
	public static bool AreCameraKeyboardButtonsPressed () {
		if(Input.GetKey(KeyCode.W) || Input.GetKey(KeyCode.S) || Input.GetKey(KeyCode.A) || Input.GetKey(KeyCode.D))
			return true; else return false;
	}
	
	public static bool IsMousePositionWithinBoundaries () {
		if(
			(Input.mousePosition.x < mouseScrollLimits.LeftLimit && Input.mousePosition.x > -5) ||
			(Input.mousePosition.x > (Screen.width - mouseScrollLimits.RightLimit) && Input.mousePosition.x < (Screen.width + 5)) ||
			(Input.mousePosition.y < mouseScrollLimits.BottomLimit && Input.mousePosition.y > -5) ||
			(Input.mousePosition.y > (Screen.height - mouseScrollLimits.TopLimit) && Input.mousePosition.y < (Screen.height + 5))
			)
				return true; else return false;
	}
	#endregion
}
