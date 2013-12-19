using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class AudioTrigger : MonoBehaviour {

	public GameObject[] OnEnterStartTargets;
	public GameObject[] OnEnterPauseTargets;
	public GameObject[] OnEnterRestartTargets;

	public GameObject[] OnExitStartTargets;
	public GameObject[] OnExitPauseTargets;
	public GameObject[] OnExitRestartTargets;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}


	void OnTriggerEnter(Collider col)
	{
		StartAll (OnEnterStartTargets);
		PauseAll (OnEnterPauseTargets);
		RestartAll (OnEnterRestartTargets);
	}

	void OnTriggerExit(Collider col)
	{
		StartAll (OnExitStartTargets);
		PauseAll (OnExitPauseTargets);
		RestartAll (OnExitRestartTargets);
	}


	public void StartAll(IEnumerable<GameObject> targets)
	{
		foreach (GameObject go in targets) 
		{
			if ( go.audio != null )
			{
				if ( !go.audio.isPlaying )
					go.audio.Play();
			}
		}
	}

	public void PauseAll(IEnumerable<GameObject> targets)
	{
		foreach (GameObject go in targets) 
		{
			if ( go.audio != null )
			{
				if (go.audio.isPlaying)
					go.audio.Pause();
			}
		}
	}

	public void RestartAll(IEnumerable<GameObject> targets)
	{
		foreach (GameObject go in targets) 
		{
			if ( go.audio != null )
			{
				go.audio.Stop();
				go.audio.Play();
			}
		}
	}

}
