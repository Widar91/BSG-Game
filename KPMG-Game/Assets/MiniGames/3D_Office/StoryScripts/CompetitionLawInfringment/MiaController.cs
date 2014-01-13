using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class MiaController : PersonController {

	protected override void Start() {
		base.Start ();
		storyName = "mia";

		Sit ();
	}

}